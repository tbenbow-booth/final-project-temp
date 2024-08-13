class HomeController < ApplicationController
  require 'twilio-ruby'
  #test

  def index
    render(template: "home/index")
  end

  def text
    phone_number = params.fetch("phone_number")

    if valid_phone_number?(phone_number)
      if send_text_message(phone_number)
        redirect_to("/", notice: "Text successfully sent.")
      else
        redirect_to("/", alert: "Failed to send text message. Please try again!")
      end
    else
      redirect_to("/", alert: "Phone number not valid. Please try again!")
    end
  end

  private

  def valid_phone_number?(phone_number)
    # Simple validation for phone number format (basic check)
    phone_number.match?(/\A\+\d{1,3}\d{10}\z/)
  end

  def send_text_message(to)
    begin
      client = Twilio::REST::Client.new(
        '',
        ''
      )

      message = client.messages.create(
        from: "+", # 
        to: "+", # Use the method parameter 'to' correctly
        body: "Hello! This is a test message from your Rails app."
      )

      Rails.logger.info("Message sent: #{message.sid}")
      return true
    rescue Twilio::REST::RestError => e
      Rails.logger.error("Twilio error: #{e.message}")
      return false
    end
  end
end
