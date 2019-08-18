<?php

namespace App\Controllers;

use App\Models\Chains;

class ChainsController extends ControllerBase {

	public function indexAction() {
        $this->tag->prependTitle("Chains");
        $this->view->meta_d = "Nugget Watch tracks chicken nugget prices around New Zealand so that you don't have to. Hungry for nuggies? We got you covered.";
        $this->view->chains = Chains::Find();
	}

    public function viewAction($nicename = null) {
        if (is_null($nicename)) {
            $this->dispatcher->forward([
                "controller" => "chains",
                "action"     => "index"
            ]);
           return false;
        }
        $chain = Chains::findFirstByNicename($nicename);
        if (!$chain || $nicename == null) {
            $this->dispatcher->forward([
                "controller" => "error",
                "action"    => "show404",
            ]);
            return false;
        }

        $this->tag->prependTitle($chain->name);
        $this->view->chain = $chain;
    }
}
