<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Chains extends Model
{
    public $id;
    public $name;
    public $rating;

	public function initialize() {
		$this->hasMany(
			'id', 
			'App\Models\Prices', 
			'chain', 
			[
				'alias' => 'prices',
				'params' => [
					'order' => 'per ASC',
					'current = 1',
				],
			]);
        $this->hasMany(
            'id',
            'App\Models\Reviews',
            'chain',
            [
                'alias' => 'reviews',
                'params' => [
                    'order' => 'date DESC',
                ]
            ]
        );
	}

    public static function top() {
        return self::findFirst([
            "order" => "rating DESC",
        ]);
    }
}
