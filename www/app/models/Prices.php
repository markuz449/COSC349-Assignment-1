<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Prices extends Model
{
    public $id;
    public $chain;
    public $price;
    public $number;
    public $per;
    public $date;
    public $comments;
    public $current;
    public $checked;

    public function initialize() {
        $this->belongsTo('chain', 'App\Models\Chains', 'id', ['alias' => 'place']);
        $this->hasMany('id', 'App\Models\Tags', 'price', ['alias' => 'tags']);
    }

    public static function cheapest() {
        return $cheapest = self::findFirst([
            "where" => "current = 1",
            "order" => "per ASC",
            "limit" => "1",
        ]);
    }
}
