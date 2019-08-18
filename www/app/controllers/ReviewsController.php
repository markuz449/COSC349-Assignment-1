<?php

namespace App\Controllers;

use App\Models\Chains;
use App\Models\Reviews;

class ReviewsController extends ControllerBase {

	public function indexAction() {
        $this->tag->prependTitle("Reviews");
		$chains = Chains::find();
		$this->view->chains = $chains;
        $this->view->reviews = Reviews::Find([
            "order"     => "date DESC",
        ]);
	}

    public function viewAction($id = null) {
        $this->tag->prependTitle("Author");
        $review = Reviews::findFirst($id);
        $this->view->reviews = Reviews::findByEmail($review->email);
    }

    public function deleteAction($id) {
        $review = Reviews::findFirstById($id);
        $review->delete();
        if ($review) {
            $this->flashSession->success("Review has been deleted");
            return $this->response->redirect("reviews");
        } else {
            $this->flashSession->error("Something has gone wrong");
            return $this->response->redirect("reviews");
        }
    }

}
