class TwilioClient
  def self.available_phone_numbers(area_code)
    new.available_phone_numbers(area_code)
  end

  def self.purchase_phone_number(phone_number)
    new.purchase_phone_number(phone_number)
  end

  def initialize
    # To find TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN visit
    # https://www.twilio.com/user/account
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token  = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def available_phone_numbers(area_code = '415')
    client.available_phone_numbers('US').local.list(area_code: area_code).take(10)
  end

  def purchase_phone_number(phone_number)
    application_sid = ENV['TWIML_APPLICATION_SID'] || sid
    client.incoming_phone_numbers.
      create(phone_number: phone_number, voice_application_sid: application_sid)
  end

  private

  DEFAULT_APPLICATION_NAME = 'Call tracking app'

  def sid
    applications = @client.applications.list(friendly_name: DEFAULT_APPLICATION_NAME)
    if applications.any?
      applications.first.sid
    else
      @client.applications.create(friendly_name: DEFAULT_APPLICATION_NAME).sid
    end
  end

  attr_reader :client
end
