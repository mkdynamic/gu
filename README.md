# Gu 

A simple way to use Backpack as a CMS.

## Overview

The idea of this little rails app is to allow you to use [37signals' Backpack](http://www.backpackit.com) as a simple CMS for your website.

It's aimed at very simple websites, where a full blown CMS would be overkill. It takes advantage of functionality already provided in Backpack for managing content.

## Demo

Check out this [demo running on Heroku](http://gudemo.heroku.com).

## Setup

You need to create a file called `config/backpack.yml`, as follows:

    username: foo
    token: your_api_key_from_backpack

## Conventions

Gu infers the hierarchical structure of the website (which is not provided by Backpack) from the name of the pages. Therefore, you need to stick to strict naming conventions for your Backpack pages in order for this to work.

* Make sure the home page is called **Home**.
* Name other pages like **Home > About Us**, or **Home > Services > Design**

NB. You must all make all pages you wish to use public in Backpack.

## Caching

Currently the pages are simply cached using Rails built in page caching. You have to invalidate the cache manually at the moment, but ideally this could be done automatically by polling Backpack and checking for changes.

## Credits

Written by Mark Dodwell ([@madeofcode](http://twitter.com/madeofcode))
 

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/mkdynamic/gu/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

