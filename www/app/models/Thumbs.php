<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Thumbs extends Model
{
    public $webid;
    public $ip;
    public $agent;
    public $date;
    public $up;

	public function initialize() {
	}
}
