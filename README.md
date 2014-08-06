Photo Challenges
================

[![Build Status](https://travis-ci.org/clintonb/photo-challenges.svg?branch=master)](https://travis-ci.org/clintonb/photo-challenges)

This project is very similar to dailyshoot.com. Each day a new shoot idea is posted. Users submit their photos by tagging them on certain social networks (e.g. Twitter, Instagram, Flickr). This project differs from dailyshoot.com by allowing users to submit and vote on ideas, and allowing voting on the photos.


Getting Started
---------------

1. The major functionality of this app--retrieving photos--relies on the Twitter API. Head over to [https://dev.twitter.com/](https://dev.twitter.com/), create a new app, and add your credentials to config/app.yml. See app.yml.sample for an example of how the file should be structured.

2. Create config/database.yml. Use database.yml.sample as an example.

3. Run the following commands to initialize your database:

        $ bin/rake db:create
        $ bin/rake db:migrate

4. *(Optional)* Add a few fake users, challenges, and photos to your database by running `bin/rake db:seed`.

5. Start the web server with `rails s`.

6. In another console window start the Twitter photo finder with `bin/rake photofinder:twitter`.

That's it for getting the server running. The site should now be available at http://localhost:3000 (unless you changed the port).


Running Tests
-------------

        $ bin/rake db:migrate RAILS_ENV=test
        $ bin/rake spec


Using the Application
---------------------

1. Select or create a new challenge.

2. Send a tweet with an embedded photo and a hashtag corresponding to the challenge. For example, the hashtag for Challenge #86 would be #pc86.

3. You should see the tweet in the console of the photofinder. Additionally, it should appear on the challenge's detail page.

4. Log into the application as your Twitter account. The photo should be associated with your account.


Remaining Work
--------------

This is very much a work-in-progress, and much work remains...

* Design a proper UI that isn't simply the default Bootstrap scheme
* Rethink the UX. (Is the current navigation really the best?)
* Follow Twitter links and parse <twitter:image> and <og:image> URLs. This will allow linked photos in Tweets (e.g. flic.kr links) to be retrieved.
* Pull photos from other sites (e.g. Instagram, 500px, Facebook?)
* Implement proper permissions
* Design user profiles
* Add voting for photos
* Add rake task to create daily challenge
