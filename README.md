<a href="https://www.twilio.com">
  <img src="https://static0.twilio.com/marketing/bundles/marketing/img/logos/wordmark-red.svg" alt="Twilio" width="250" />
</a>

# Receive MMS: Process MMS messages received by the application using rails

[![Build Status](https://travis-ci.org/TwilioDevEd/receive-mms-rails.svg)](https://travis-ci.org/TwilioDevEd/receive-mms-rails)

[![Coverage Status](https://coveralls.io/repos/github/TwilioDevEd/receive-mms-rails/badge.svg?branch=master)](https://coveralls.io/github/TwilioDevEd/receive-mms-rails?branch=master)

## Local development

This project is built using the [Ruby on Rails](http://rubyonrails.org/) web framework.

1. First clone this repository and `cd` into it

   ```bash
   $ git clone git@github.com:TwilioDevEd/receive-mms-rails.git
   $ cd receive-mms-rails
   ```

1. Install the dependencies

   ```bash
   $ bundle
   ```

1. Copy the sample configuration file and edit it to match your configuration

  ```bash
  $ cp .env.example .env
  ```

 You can find your `TWILIO_ACCOUNT_SID` and `TWILIO_AUTH_TOKEN` in your
 [Twilio Account Settings](https://www.twilio.com/user/account/settings).
 You will also need a `TWILIO_NUMBER`, which you may find [here](https://www.twilio.com/user/account/phone-numbers/incoming).

 Run `source .env` to export the environment variables

1. Create database and run migrations

   ```bash
   $ bundle exec rake db:setup
   ```

1. Make sure the tests succeed
   ```bash
   $ bundle exec rspec
   ```

1. Run the server

   ```bash
   $ bundle exec rails s
   ```

1. Expose your application to the wider internet using [ngrok](http://ngrok.com). This step
  is important because the application won't work as expected if you run it through
  localhost.

  ```bash
  $ ngrok http 3000
  ```

  Once ngrok is running, open up your browser and go to your ngrok URL. It will
  look something like this: `http://9a159ccf.ngrok.io`

  You can read [this blog post](https://www.twilio.com/blog/2015/09/6-awesome-reasons-to-use-ngrok-when-testing-webhooks.html)
  for more details on how to use ngrok.

1. Configure Twilio to call your webhooks

  You will also need to configure Twilio to call your application when calls are received on your `TWILIO_NUMBER`. The voice url should look something like this:

  ```
  http://6b5f6b6d.ngrok.io/mms_resources
  ```

  ![Configure Voice](http://howtodocs.s3.amazonaws.com/twilio-number-config-all-med.gif)


That's it!

## How to Demo

1. Send an MMS to your twilio number

1. Access `http://localhost:3000`. You should see a list with all the resources
sent through your MMS

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
