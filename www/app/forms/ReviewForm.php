<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Validation\Validator\Between;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\File as FileValidator;
use Phalcon\Validation\Validator\Email as EmailValidator;
use App\Models\Chains;

class ReviewForm extends Form
{
    public function initialize($entity = null, $options = null)
    {
        // Name
        $name = new Text('name', [
            "autofocus" => "autofocus",
            "required" => "required",
            "class" => "u-full-width",
        ]);
        $name->setLabel('Name');
        $name->setFilters(['striptags', 'string']);
        $name->addValidators([
            new PresenceOf([
                'message' => 'Name is required'
            ])
        ]);
        $this->add($name);
        $chain = new Select(
            'chain',
            Chains::find(),
            [
                'using' => ['nicename', 'name'],
                'required' => 'true',
                'useEmpty' => true,
                'class' => 'u-full-width',
            ]
        );
        $chain->setLabel("Chain");
        $this->add($chain);
        // Comments
        $name = new TextArea('comments', [
            "class" => "u-full-width",
            "rows" => "4",
        ]);
        $name->setLabel('Review Comments');
        $name->setFilters(['striptags']);
        $this->add($name);
        // Email
        $email = new Email('email', [
            "required"  => "required",
            "class" => "u-full-width",
        ]);
        $email->setLabel('Email');
        $email->setFilters('email');
        $email->addValidators([
            new PresenceOf([
                'message' => 'E-mail is required'
            ]),
            new EmailValidator([
                'message' => 'E-mail is not valid'
            ])
        ]);
        $this->add($email);

        $flavour = new Numeric("flavour");
        $flavour->addValidators([
            new Between([
                "minimum" => 1,
                "maximum" => 5,
                "message" => "Please rate every factor",
                "cancelOnFail" => true,
            ]),
        ]);
        $this->add($flavour);
        $mouthfeel = new Numeric("mouthfeel");
        $mouthfeel->addValidators([
            new Between([
                "minimum" => 1,
                "maximum" => 5,
                "message" => "Please rate every factor",
                "cancelOnFail" => true,
            ]),
        ]);
        $this->add($mouthfeel);
        $coating = new Numeric("coating");
        $coating->addValidators([
            new Between([
                "minimum" => 1,
                "maximum" => 5,
                "message" => "Please rate every factor",
                "cancelOnFail" => true,
            ]),
        ]);
        $this->add($coating);
        $sauces = new Numeric("sauces");
        $sauces->addValidators([
            new Between([
                "minimum" => 1,
                "maximum" => 5,
                "message" => "Please rate every factor",
                "cancelOnFail" => true,
            ]),
        ]);
        $this->add($sauces);
        $overall = new Numeric("overall");
        $overall->addValidators([
            new Between([
                "minimum" => 1,
                "maximum" => 5,
                "message" => "Please rate every factor",
                "cancelOnFail" => true,
            ]),
        ]);
        $this->add($overall);
    }
}
