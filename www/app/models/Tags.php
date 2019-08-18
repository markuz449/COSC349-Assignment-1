<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Tags extends Model
{
    public $price;
    public $tag;
    public $colour;

    public function initialize() {
        $this->belongsTo('price', 'App\Models\Prices', 'id', ['alias' => 'price']);
    }
}
