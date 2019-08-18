<?php

namespace App\Controllers;

use App\Models\Thumbs;
use App\Models\Chain;
use PHalcon\Http\Response;

class RateController extends ControllerBase {

	public function upAction($uuid) {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_NO_RENDER);
        $thumb = new Thumbs();
        $thumb->webid = $uuid;
        $thumb->agent = $this->request->getUserAgent();
        $thumb->ip = $this->request->getClientAddress();
        $thumb->up = 1;
        $response = new Response();
        if ($thumb->save()) {
            $response->setStatusCode(200, "Success");
            $response->send();
            return false;
        } else {
            $response->setStatusCode(501, "Failed");
            $response->send();
            return false;
        }
	}

	public function downAction($uuid) {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_NO_RENDER);
        $thumb = new Thumbs();
        $thumb->webid = $uuid;
        $thumb->agent = $this->request->getUserAgent();
        $thumb->ip = $this->request->getClientAddress();
        $thumb->up = 0;
        $response = new Response();
        if ($thumb->save()) {
            $response->setStatusCode(200, "Success");
            $response->send();
            return false;
        } else {
            $response->setStatusCode(501, "Failed");
            $response->send();
            return false;
        }
	}
}
