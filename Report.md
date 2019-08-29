---
output: pdf_document
title: COSC349 Assignment 1
---

# Notes:

- Nathan will compile this document to PDF before submitting
- This section is to be removed

# Group:

- Marcus Anderson ()
- Nathan Hollows (6887316)

# Nugget Watch

Nugget Watch aims to be the Wikipedia of chicken nugget prices. Nugget Watch has prices listed from the largest ready-to-eat chicken nugget suppliers in New Zealand. Nugget Watch also allows customers to rate and review their nuggets as well as upload images with their reviews.

## The virtual machines

Nugget Watch is deployed over three virtual machines. `webserver` is the virtual machine responisble for serving webpages. This server runs Apache to display our web pages that are written in PHP and the Phalcon framework. 

`dbserver` runs the database and uses MySQL.

`imgsever` is responsible for compressing and resizing images. This server uses ImageMagick for resizing and cron for scheduling.

# Build System

`vagrant up`

# How to use NuggetWatch 

## Register

## Reviewing

## Perusing

# Useful Modifications

## Extend the API

- GET Nearest nugget
- GET Best nugget
- GET Nugget prices
- GET / POST / PUT / PATCH / DELETE Reviews

## Implement map functionality

## Rating Reviews

