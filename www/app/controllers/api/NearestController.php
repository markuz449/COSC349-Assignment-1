<?php

namespace App\API;

use App\Models\Locations;
use Phalcon\Http\Response;

class NearestController extends ControllerBase {

    public function indexAction() {
        $response = new Response();
        $response->setHeader('Content-Type', 'application/json');
        if ($this->request->isGet()) {
            $lat = $this->request->get('lat');
            $lng = $this->request->get('lng');
            if (!is_null($lat) && !is_null($lng)) {
                $response->setStatusCode(200, 'Okay');
                $response->setContent(json_encode(Locations::findFirst()->toArray(), JSON_NUMERIC_CHECK));
            }
        }
        $response->send();
    }

}
