# coding: utf-8
require 'modules/place'
require 'modules/zipcode'
require 'modules/convert'
require 'SlackBot'

class Parse_request < SlackBot

  def initialize(settings_file_path = "settings.yml")
    config = YAML.load_file(settings_file_path) if File.exist?(settings_file_path)
    @place_api_url = config["place_api_url"]
    @zipcode_api_url = config["zipcode_api_url"]
    @map_api_url =config["map_api_url"]
    @api_key = config["api_key"]
    @user_name = config["user_name"]
    @user_id = config["user_id"]
  end

  def parse_request(params, options = {})

    slackbot = SlackBot.new

    if params[:user_name] != @user_name || params[:user_id] != @user_id then
      return nil
    end
    
    parse_text = params[:text].split(/[「|」]/)
    
    if parse_text[2] == nil then
      return nil
    elsif parse_text[2].index("と言って") != nil then
      message = parse_text[1]
    elsif parse_text[2] =~ /"の住所を検索.*/ then
      request = Zipcode_API.generate_request(parse_text[1])
      response = slackbot.get_response(@zipcode_api_url,request)
      message = Zipcode_API.generate_message(response)
    elsif parse_text[2] =~ /のコンビニを[1-9][0-9]*件検索.*/ then
      num = parse_text[2].match(/\d+/)[0].to_i
      request = Place_API.generate_request(parse_text[1],@api_key)
      response = slackbot.get_response(@place_api_url,request)
      message = Place_API.generate_message(response,@map_api_url,num-1)
    else
      return nil
    end
    escape_message = Convert.escape_letter(message)
    #puts escape_message
    slackbot.post_message(escape_message,params[:user_id],options)
    return nil
  end
end
    
