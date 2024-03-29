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
        $review = Reviews::findFirstByWebid($id);
        $this->view->reviews = Reviews::findByEmail($review->email);
    }

    public function deleteAction($id) {
        $review = Reviews::findFirstByWebid($id);
        $review->delete();
        if ($review) {
            $this->flashSession->success("Review has been deleted");
            return $this->response->redirect("reviews");
        } else {
            $this->flashSession->error("Something has gone wrong");
            return $this->response->redirect("reviews");
        }
    }

    public function featureAction($id) {
        $review = Reviews::findFirstByWebid($id);
        // check if the reviews exists
        if (!$review) {
            $this->flashSession->error("The review could not be found");
            return $this->response->redirect("reviews");
        }

        // Toggle featured
        if ($review->featured == 1) {
            $review->featured = 0;
        } else {
            // Check if another review is featured
            $old = Reviews::findFirst(["featured = 1 AND chain = $review->chain"]);
            // Remove he featured flag
            if ($old) {
                $old->featured = 0;
                $old->save();
            };
            $review->featured = 1;
        }

        // Check if the review has been successfully saved
        if ($review->save()) {
            $this->flashSession->success("Featured review set successfullly");
            return $this->response->redirect("reviews");
        } else {
            $this->flashSession->error("The featured review could not be set");
            return $this->response->redirect("reviews");
        }

    }

}
