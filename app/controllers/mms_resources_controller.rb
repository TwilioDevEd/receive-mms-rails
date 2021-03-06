require 'open-uri'

class MmsResourcesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @twilio_number = ENV.fetch('TWILIO_NUMBER')
    @files = MmsResource.all
  end

  def create
    (0..num_media - 1).each do |index|
      media_url    = params["MediaUrl#{index}"]
      content_type = params["MediaContentType#{index}"]
      message_sid  = params["MessageSid"]
      mms_resource = MmsResource.new(filename: file_name(media_url, content_type))
      uri = URI.parse(media_url)
      IO.copy_stream(uri.open, mms_resource.path)
      # For development purposes, this will make an async call to delete the media when it is received
      Concurrent::Future.execute{ delete_media(message_sid, media_url) if mms_resource.save }
    end

    response = Twilio::TwiML::MessagingResponse.new do |r|
      body = num_media > 0 ? "Thanks for sending us #{num_media} file(s)!" : 'Send us an image!'
      r.message body: body
    end
    render xml: response.to_xml
  end

  private

  def twilio_client
    Twilio::REST::Client.new(ENV.fetch('TWILIO_ACCOUNT_SID'), ENV.fetch('TWILIO_AUTH_TOKEN'))
  end

  def delete_media(message_sid, media_url, repetition = 0)
    Retriable.retriable(on: Twilio::REST::RestError, tries: 6, base_interval: 2) do
      twilio_client.api.accounts(ENV.fetch('TWILIO_ACCOUNT_SID'))
        .messages(message_sid)
        .media(media_id(media_url))
        .delete
    end
    puts "MEDIA DELETED!"
  end

  def num_media
    params["NumMedia"].to_i
  end

  def file_name(media_url, file_type)
    "#{media_id(media_url)}#{file_extension(file_type)}"
  end

  def file_extension(media_type)
    Rack::Mime::MIME_TYPES.invert[media_type]
  end

  def media_id(media_url)
    URI(media_url).path.split('/').last
  end
end
