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

   _Make sure you have installed [PostgreSQL](http://www.postgresql.org/). If on
   a Mac, I recommend [Postgres.app](http://postgresapp.com)_.

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
  http://9a159ccf.ngrok.io/conference/connect/client
  ```

  ![Configure Voice](http://howtodocs.s3.amazonaws.com/twilio-number-config-all-med.gif)


That's it!

## How to Demo

1. Navigate to `https://<ngrok_subdomain>.ngrok.io` in two different
   browser tabs or windows.

   **Notes:**
   * Remember to use your SSL enabled ngrok url `https`.
   Failing to do this won't allow you to receive incoming calls.
   * The application has been tested with [Chrome](https://www.google.com/chrome/)
   and [Firefox](https://firefox.com). Safari is not supported at the moment.

1. In one window/tab click `Connect as Agent 1` and in the other one click
   `Connect as Agent 2`. Now both agents are waiting for an incoming call.

1. Dial your [Twilio Number]() to star a call with `Agent 1`. Your `TWILIO_NUMBER`
   environment variable was set when configuring the application to run.

1. When `Agent 1` answers the call from the client, he/she can dial `Agent 2` in
   by clicking on the `Dial agent 2 in` button.

1. Once `Agent 2` answers the call all three participants will have joined the same
   call. After that `Agent 1` can drop the call and leave both the client and `Agent 2`
   having a pleasant talk.

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
