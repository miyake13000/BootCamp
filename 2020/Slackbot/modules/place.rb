
module Place_API
  
  def generate_request(address, api_key)

    request = {query: "#{address}",laungage: "ja",type: "convenience_store",key: "#{api_key}"}

    return request
  end
  module_function :generate_request

  def generate_message(response,map_url,num)

    if response["status"] == "OK" then
      message = ""
      for i in 0..num
        if response.dig("results",i) == nil
          break
        else
          place_name = response.dig("results",i,"name")
          place_id = response.dig("results",i,"place_id")
          message = message + "#{place_name}\n #{map_url}#{place_id}\n"
        end
      end
    elsif response["status"] == "ZERO_RESULTS" then
      message = "No Hit."
    else
      message = "Failed to serch convenience_store."
    end

    return message
  end
  module_function :generate_message
end
      
