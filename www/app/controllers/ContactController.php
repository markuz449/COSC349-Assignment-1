<?php

namespace App\Controllers;

use Phalcon\Http\Request;
use Phalcon\Filter;
use App\Models\Messages;

class ContactController extends ControllerBase {

	public function indexAction() {
        $this->tag->prependTitle("Contact");
		$request = new Request();
		$filter = new Filter();

		if ($request->isPost()) {
			$message = new Messages;
			$message->date = date("Y-m-d H:i:s");
			$message->name = $filter->sanitize($request->getPost('name'), 'string');
			$message->email = $filter->sanitize($request->getPost('email'), 'email');
			$message->message = $filter->sanitize($request->getPost('message'), 'string');
			$message->browser = $filter->sanitize($request->getUserAgent(), 'string');
			$message->ip = $filter->sanitize($request->getClientAddress(), 'string');
			if ($message->save()) {
				print "Thank you for getting in touch.";
			} else {
				foreach ($message->getMessages() as $error) {
					print $error;
				}
			}
		}
	}
}
