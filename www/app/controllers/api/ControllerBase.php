<?php

namespace App\API;

use Phalcon\Mvc\Controller;

class ControllerBase extends Controller {

    public function beforeExecuteRoute() {
        $this->view->disable();
    }
}
?>
