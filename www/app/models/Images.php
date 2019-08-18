<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Images extends Model
{
    public $webid;
    public $image;

    public function initialize() {
        $this->belongsTo('webid', 'App\Models\Reviews', 'webid', ['alias' => 'review']);
    }

    public function beforeDelete() {
        try {
            unlink("/var/www/html/public/img/full/" . $this->filename . ".jpg");
            unlink("/var/www/html/public/img/thumbnails/" . $this->filename . ".jpg");
        } catch(Exception $e) {
            $this->flashSession->error("One or more images could not be deleted");
        }
    }
}
