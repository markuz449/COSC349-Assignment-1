<?php

namespace App\Controllers;

class AboutController extends ControllerBase {

	public function indexAction() {
        $this->tag->prependTitle("About");
        $this->view->meta_d = "Nugget Watch, the Wikipedia of chicken nugget deals. Nugget Watch is for that special kind of person that both loves chicken nuggets and great deals. You're welcome.";
	}

    public function termsAction() {

    }

    public function privacyAction() {
        $this->tag->prependTitle("Privacy Policy");
    }
}
