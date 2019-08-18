<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Messages extends Model {

	public $id;
	public $email;
	public $subject;
	public $message;
	public $datetime;
	public $browser;
	public $ip;

}
