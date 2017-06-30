class MmsResourcesController < ApplicationController
  def index
    @twilio_number = ENV['TWILIO_NUMBER']
    @files = MmsResource.all
  end

  def create
    (0..num_media-1).each do |index|
      media_url = params["MediaUrl#{index}"]
      file_type = params["MediaContentType#{index}"]
      message_sid = params["MessageSid"]
      mms_resource = MmsResource.new(filename: file_name(media_url, file_type))
      IO.copy_stream(open(media_url), mms_resource.path)

      mms_resource.save

      delete_media(message_sid, media_url)
    end

    message = num_media <= 0 ? 'Send us an image' : 'Thanks for the 1 images'
    response = Twilio::TwiML::MessagingResponse.new
    response.message message

    render xml: response.to_xml_str
  end

  private

  def delete_media(message_sid, media_url, repetition=0)
    twilio_client.api.accounts(ENV['TWILIO_ACCOUNT_SID'])
      .messages(message_sid)
      .media(resource_id(media_url))
      .delete
  rescue Twilio::REST::RestError => error
    raise error if repetition >= 4
    sleep 10
    delete_media(message_sid, media_url, repetition+1)
  end

  def num_media
    params["NumMedia"].to_i
  end

  def media_url
  end

  def file_name(media_url, file_type)
    "#{resource_id(media_url)}#{file_extension(file_type)}"
  end

  def file_extension(media_type)
    Rack::Mime::MIME_TYPES.invert[media_type]
  end

  def resource_id(media_url)
    uri = URI.parse(media_url)
    File.basename(uri.path)
  end

  def twilio_client
    @_client ||= Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end
end
