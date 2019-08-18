<?php

namespace App\Controllers;

use App\Models\Chains;
use App\Models\Prices;

class IndexController extends ControllerBase
{
    public function indexAction() {
        $this->view->meta_d = "Nugget Watch keeps you in the loop with the best chicken nugget deals around New Zeland, and reviews to guide you through your chicken nugget journey.";
        $this->tag->setTitle("Nugget Watch - the cheapest chicken nugget prices in New Zealand");

        $this->view->chains = Chains::find();
        $herotext = [
            "The Wikipedia of chicken nugget prices",
            "We're on <a href='https://www.instagram.com/nuggetwatchnz/' target='_blank'>Instagram!</a>",
            "Because onion rings are for chumps",
            "The proud result of a time-rich uni student",
            "Ask your doctor if Nuggets are right for you",
            "This was a good use of my time",
            "I didn't choose the nug' life",
            "#nugsnotdrugs",
            'You\'re welcome.',
            '<a href="https://www.youtube.com/watch?v=ig_31wXp2R4" target="_blank">You\'re welcome.</a>',
            '!hctaW tegguN',
            'I\'m nuggin\' it',
        ];
        $this->view->herotext = $herotext[mt_rand(0, count($herotext) - 1)];
    }
}
