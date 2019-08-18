<?php

namespace App\Controllers;

use App\Models\Messages;

class MessagesController extends ControllerBase {

	public function indexAction() {

        $this->tag->prependTitle("Messages");
		$this->view->messages = Messages::find([
            "conditions" => "deleted <> 1",
			"order" => "datetime DESC",
		]);

	}

    public function readAction($id = null) {

        $message = Messages::FindFirst($id);
        if (!$message || $message->deleted == 1) {
            $this->dispatcher->forward([
                "controller"    => "error",
                "action"        => "show404",
            ]);
            return false;
        }
        $this->tag->prependTitle("Reading Message");
        if ($message->read == 0) {
            $message->read = 1;
            $message->update();
        }
        $this->view->message = $message;
    }

    public function deleteAction($id = null) {

        $message = Messages::FindFirst($id);
        if (!$message || $message->deleted) {
            $this->dispatcher->forward([
                "controller"    => "error",
                "action"        => "show404",
            ]);
            return false;
        }
        $message->deleted = 1;
        if ($message->save()) {
            $this->flash->success("Successfully deleted message");
        } else {
            foreach ($message->getMessages() as $error) {
                print $error;
            }
        }
        return $this->dispatcher->forward([
            "controller" => "messages",
            "action"     => "index",
        ]);
        $this->view->message = $message;
    }
}
