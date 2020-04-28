# coding: utf-8

module Zipcode_API

  def generate_request(zipcode)

    request = {zipcode: "#{zipcode}"}

    return request
  end
  module_function :generate_request

  def generate_message(response)
    
    if response["status"] == 200 then
      message = response.dig("results",0,"address1") +
                response.dig("results",0,"address2") +
                response.dig("results",0,"address3") + "（" +
                response.dig("results",0,"kana1")    +
                response.dig("results",0,"kana2")    +
                response.dig("results",0,"kana3")    + "）"
    elsif response["status"] == 400 then
      message = "Invalid zipcode"
    else
      message = "Failed to exchange zipcode to address"
    end

    return message
  end
  module_function :generate_message
end
