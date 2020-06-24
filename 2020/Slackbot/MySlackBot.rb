
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'sinatra'
require 'Parse_request'

class MySlackBot < Parse_request
  # cool code goes here
end

parse_request = Parse_request.new

set :environment, :production

get '/' do
  "SlackBot Server"
end

post '/slack' do
  content_type :json
  #slackbot.naive_respond(params, username: "MiyakeBot")
  parse_request.parse_request(params,username:"MiyakeBot")
end
