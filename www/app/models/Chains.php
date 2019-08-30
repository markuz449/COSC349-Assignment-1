<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Chains extends Model
{
    public $id;
    public $name;
    public $rating;

    // Set up relationships between models
	public function initialize() {
        // Each chain has many prices
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
        // Chain has many reviews
        $this->hasMany(
            'id',
            'App\Models\Reviews',
            'chain',
            [
                'alias' => 'reviews',
                'params' => [
                    // Bring featured reviews to the top then sort the rest by
                    // date
                    'order' => 'featured DESC, date DESC',
                ]
            ]
        );
	}

    // Return the chain with the highest overall rating
    public static function top() {
        return self::findFirst([
            "order" => "rating DESC",
        ]);
    }
}
