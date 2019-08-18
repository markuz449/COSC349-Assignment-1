<?php

namespace App\Controllers;

use App\Forms\ReviewForm;
use App\Models\Chains;
use App\Models\Images;
use App\Models\Reviews;
use Phalcon\Security\Random;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Validation\Validator\File as Image;

class ReviewController extends ControllerBase {

    public function indexAction($nicename = null) {

        $form = new ReviewForm();

        if (!is_null($nicename)) {
            $chain = Chains::findFirstByNicename($nicename);
            if (!$chain) {
                $this->dispatcher->forward([
                    "controller" => "error",
                    "action"     => "show404",
                ]);
                return false;
            }
            $this->view->chain = $chain;
        }

        if ($this->request->isPost()) {
            # Set up the random generator for webid and filenames
            $random = new Random();

            # If there is chain set then grab that now
            if (!isset($chain)) {
                $chain = Chains::findFirstByNicename($this->request->getPost("chain", "string"));
            }

            $images = $this->manageFiles($this->request->getUploadedFiles());

            if (count($images) > 0) {
                $this->view->images = $images;
            }


            if (!$form->isValid($this->request->getPost())) {
                $messages = $form->getMessages();
                foreach ($messages as $message) {
                    $this->flash->error($message);
                }
            } else {

                $review = Reviews::findFirst([
                    "email = ?0 AND chain = ?1",
                    "bind"  => [
                        $this->request->getPost("email"),
                        $chain->id,
                    ]
                ]);

                if (!$review) {
                    $review = new Reviews();
                }

                $review->name = $this->request->getPost("name", "string");
                $review->email = $this->request->getPost("email", "string");
                $review->comments = $this->request->getPost("comments", ["striptags"]);
                $review->flavour = $this->request->getPost("flavour", "int");
                $review->mouthfeel = $this->request->getPost("mouthfeel", "int");
                $review->coating = $this->request->getPost("coating", "int");
                $review->sauces = $this->request->getPost("sauces", "int");
                $review->overall = $this->request->getPost("overall", "int");
                $review->chain = $chain->id;
                $webid = $random->uuid();
                $review->webid = $webid;

                if(!$review->save()) {
                    foreach ($review->getMessages() as $message) {
                        $this->flash->error($message);
                    }
                } else {
                    foreach ($images as $image) {
                        $imageEntry = new Images();
                        $imageEntry->webid = $webid;
                        $imageEntry->filename = $image;
                        if($imageEntry->save()) {
                            rename("/var/www/html/app/temp/".$image,"/var/www/html/public/img/full/".$image.".jpg");
                            rename("/var/www/html/public/img/temp/".$image.".jpg","/var/www/html/public/img/thumbnails/".$image.".jpg");
                        } else {
                            $this->flashSession->error("An image could not be saved and frankly I don't know why.");
                        }

                    }
                    $this->flashSession->success("Your review has been submitted!");
                    return $this->response->redirect("chains/" . $chain->nicename);
                }
            }
        }

        $this->view->form = $form;
        $this->tag->prependTitle("Write a Review");
        $chains = Chains::find();
        $this->view->chains = $chains;
    }

    private function thumbnail($image) {
        $maxWidth = 150;
        $maxHeight = 150;
        $im = new \Imagick();
        try {
            $im->readImage("/var/www/html/app/temp/" . $image);
        } catch (\Exception $e) {
            return false;
        }
        $im->setImageFormat('jpeg');
        $geo = $im->getImageGeometry();
        $width = $geo['width'];
        $height = $geo['height'];
        if($width > $height)
        {
            $scale = ($width > $maxWidth) ? $maxWidth/$width : 1;
        }
        else
        {
            $scale = ($height > $maxHeight) ? $maxHeight/$height : 1;
        }
        $newWidth = $scale*$width;
        $newHeight = $scale*$height;
        $im->setImageCompressionQuality(85);
        $im->resizeImage($newWidth,$newHeight,\Imagick::FILTER_LANCZOS,1.1);
        if($im->writeImage("/var/www/html/public/img/temp/" . $image . ".jpg")) {
            $im->clear();
            $im->destroy();
            return true;
        } else {
            $im->clear();
            $im->destroy();
            return false;
        }
    }

    private function manageFiles($uploads) {
        $random = new Random();
        $images = [];

        # Handle each file individually
        foreach($uploads as $upload) {
            if ($upload->getSize() == 0 && count($uploads) == 1) {
                break;
            } else if ($upload->getSize() == 0) {
                continue;
            }

            # Give the file a unique name
            $name = $random->uuid();
            $path = '/var/www/html/app/temp/'.$name;

            # Move and check
            if(!$upload->moveTo($path)) {
                $this->flash->error("The image could not be uploaded: " . $upload->getName());
                continue;
            }
            if(!$this->thumbnail($name)) {
                $this->flash->error("The image could not be uploaded");
                continue;
            } else {
                array_push($images, $name);
            }
        }
        # Send the list of images to the view
        if (!is_null($this->request->getPost("images"))) {
            foreach ($this->request->getPost("images") as $image) {
                array_push($images, $image);
            }
        }

        return $images;
    }
}
