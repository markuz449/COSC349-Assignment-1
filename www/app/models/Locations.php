<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Locations extends Model
{
    public $lat;
    public $lng;
    public $chain;

	public function initialize() {
        $this->belongsTo(
            'chain',
            'App\Models\Chains',
            'id',
            [
                'alias' => 'chain',
            ]
        );
	}
}
