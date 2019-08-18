<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Relation;

class Reviews extends Model {
	public $id;
	public $name;
	public $email;
	public $chain;
	public $comments;
	public $image;
	public $flavour;
	public $mouthfeel;
	public $coating;
	public $sauces;
	public $overall;
	public $date;

	public function initialize() {
		$this->belongsTo('chain', 'App\Models\Chains', 'id', ['alias' => 'store']);
        $this->hasMany(
            'webid', 
            'App\Models\Images', 
            'webid', 
            [
                'alias' => 'images',
                'foreignKey'    => [
                    'action'    => Relation::ACTION_CASCADE,
                ],
            ]);
	}

    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }
}
