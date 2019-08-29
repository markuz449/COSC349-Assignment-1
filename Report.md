---
output: pdf_document
title: COSC349 Assignment 1
---

# Notes:

- Nathan will compile this document to PDF before submitting (this section will be deleted first)
- Replace passwords for DB before build
- Replace passwords and salts in config.php before build


# Group:

- Marcus Anderson ()
- Nathan Hollows (6887316)




# Nugget Watch

Nugget Watch aims to be the Wikipedia of chicken nugget prices. Nugget Watch has prices listed from the largest ready-to-eat chicken nugget suppliers in New Zealand. Nugget Watch also allows customers to rate and review their nuggets as well as upload images with their reviews.




# Build System

## Configure and Build

**Set secure database password:** 

Replace all instances of `insecure_db_pw` in `installs/build_database.sh` and `www/app/config/config.php` with your password of choice. 

Replace all instances of 'insecure_mysqlroot_pw' in 'installs/build_database.sh' with a new root password for the database.

**Build virtual machines:** 

`vagrant up`

## Register an admin user

Visit [http://192.168.2.11/register](http://192.168.2.11/register) to create an admin user then login with the same details (you will be redirected after successfully creating an account).




# The virtual machines

Nugget Watch is deployed over three virtual machines. Each virtual machine runs `ubuntu/bionic64`, which is downloaded once on the first build - subsequent builds use the same box file. Each webserver then downloads, compiles, and installs it's own required software, all of which is open source.

`webserver` is the virtual machine responisble for serving webpages. This virtual machine runs Apache to display our web pages that are written in PHP and the Phalcon framework. `webserver` installs apache; php and useful libraries such as imagick for initial image checks; Phalcon, an PHP framework as a C-extension; and Composer, a PHP library manager.

`dbserver` runs the database using MySQL. On initialisation this executes `installs/nugget.sql`.

`imgsever` is responsible for compressing and resizing images. This virtual machine uses ImageMagick for resizing and cron for scheduling. This server can be developed further to move and resize images for a more responsive web design, and to move original full size files to longer term storage instead of deleting originals.



# How to use NuggetWatch 

## Administrating Nugget Watch

[http://192.168.2.11/messages](http://192.168.2.11/messages) Click a name to read the message. Messages cannot be responded to from the web interface as there is no email server set up. Messages may be deleted (this sets a flag in the database to hide the message).
These messages come from the contact form located on the front end [http://192.168.2.11/contact](http://192.168.2.11/contact)

[http://192.168.2.11/prices](http://192.168.2.11/prices)

[http://192.168.2.11/reviews](http://192.168.2.11/reviews) Reviews may be deleted by admins. Other reviews submitted by the same person may also be found by clicking the `author` button.

## Reviewing

[http://192.168.2.11/review](http://192.168.2.11/review). Reviews require a name and email address.

## Perusing

[http://192.168.2.11](http://192.168.2.11)

# Useful Modifications

## Extend the API

- GET Nearest nugget
- GET Best nugget
- GET Nugget prices
- GET / POST / PUT / PATCH / DELETE Reviews

## Implement map functionality

Nugget Watch could show a map on screen

## Rating Reviews

Thumbs up / thumbs down for each review. Reviews could be rated either 'sweet' or 'sour' and could be sorted from best review to worst review.
