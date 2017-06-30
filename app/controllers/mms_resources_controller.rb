class MmsResourcesController < ApplicationController
  def index
    @twilio_number = ENV['TWILIO_NUMBER']
    @files = MmsResource.all
  end

  def create
    (0..num_media-1).each do |index|
      media_url = params["MediaUrl#{index}"]
      file_type = params["MediaContentType#{index}"]
      mms_resource = MmsResource.new(filename: "#{filename(media_url)}")
      IO.copy_stream(open(media_url), mms_resource.path)

      mms_resource.save
    end
    message = num_media <= 0 ? 'Send us an image' : 'Thanks for the 1 images'
    response = Twilio::TwiML::MessagingResponse.new
    response.message message

    render xml: response.to_xml_str
  end

  private

  def num_media
    params["NumMedia"].to_i
  end

  def file_extension(media_type)
    Rack::Mime::MIME_TYPES.invert[media_type]
  end

  def filename(media_url)
    uri = URI.parse(media_url)
    File.basename(uri.path)
  end
end
