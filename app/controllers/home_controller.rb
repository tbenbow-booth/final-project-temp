class HomeController < ApplicationController
  require "http"
  #test

  def index
    render(template: "home/index")
  end

  def text
    phone_number = params.fetch("phone_number")
    @user_number = phone_number

    if phone_number.present? && valid_phone_number?(phone_number)
      # Render the content of the ERB file to a string
      message_body = render_to_string(template: "home/message", layout: false)
      @user_text = message_body
  
      if send_text_message(phone_number, message_body)
        flash[:notice] = "Text successfully sent."
        redirect_to("/") 
      else
        flash[:alert] = "Failed to send text message. Please try again!"
        redirect_to("/")  
      end
    else
      flash[:alert] = "Phone number not valid. Please try again!"
      redirect_to("/") 
    end
  end

  private

  def valid_phone_number?(phone_number)
    # Simple validation for phone number format (basic check)
    phone_number.match?(/\A\+\d{1,3}\d{10}\z/)
  end


  def send_text_message(to, message_body)
    begin
      plan_id = "REDACTED"
      api_token = "REDACTED"
    
      url = "https://sms.api.sinch.com/xms/v1/REDACTED PLAN ID/batches"
      json_request_data = {
        "from": "REDACTED",
        "to": ["#{@user_number}"],
        "body": "#{@user_text}"
      }
      client = HTTP.auth("Bearer REDACTED API TOKEN").headers(:accept => "application/json")
  
      response = client.post(url, :json => json_request_data)
    end
  end
end
