<?php

namespace App\Controllers;

/**
 * ErrorContorller
 */

class ErrorController extends ControllerBase
{
    public function show404Action()
    {
        $this->tag->setTitle("Error 404");
        $this->response->setStatusCode(404, 'Not Found');
    }

    public function show401Action()
    {
        $this->tag->setTitle("Error 401");
        $this->response->setStatusCode(401, 'Unauthorised');
    }

    public function show500Action($exception)
    {
        $this->tag->setTitle("Error 500");
        $this->response->setStatusCode(500, 'Server Error');
	print $exception->getTraceAsString();
    }
}
