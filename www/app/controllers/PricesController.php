<?php

namespace App\Controllers;

use Phalcon\Http\Request;
use App\Models\Prices;
use App\Models\Chains;
use Abraham\TwitterOAuth\TwitterOAuth;

class PricesController extends ControllerBase {

	public function indexAction() {
        $model = new Prices();
        $model->getReadConnection()->query(
            "CALL update_tags()"
        );
        $this->tag->prependTitle("Prices");
		$request = new Request();
        $connection = new TwitterOAuth(CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET);
        $status = 'This is a test tweet.';
        // $post_tweets = $connection->post("statuses/update", ["status" => $status]);

		if ($request->isPost()) {
			$price = new Prices();
			$price->price = $request->get("price");
			$price->number = $request->get("number");
			$price->chain = $request->get("chain");
			$price->comments = $request->get("comments");
			$price->date = date("Y-m-d");
            if ($price->number != 0) {
                $price->per = round($price->price / $price->number, 2);
            }

			if ($price->save() == false) {
				echo "Something went wrong: \n";
				$messages = $price->getMessages();
				foreach($messages as $message) {
					echo $message, "<br>";
				}
			} else {
                $this->flashSession->success("Added new price");
                $chain = Chains::findFirstById($request->get("chain"));
                return $this->response->redirect("prices#" . $chain->nicename);
			}
		}

		$this->view->chains = Chains::find();
	}

	public function deleteAction($id) {
		$price = Prices::findFirstById($id);
		$price->current = 0;
		if ($price->save()) {
            $this->flashSession->success("Deleted price");
            return $this->response->redirect("prices");
		}
	}

    public function confirmAction($id) {
        $price = Prices::findFirst($id);
        $price->checked = date("Y-m-d H:i:s");
        $price->save();
        return $this->response->redirect("prices");
    }
}
