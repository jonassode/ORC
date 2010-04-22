gem 'oauth'
require 'oauth/consumer'
require 'OauthConfig'

@consumer=OAuth::Consumer.new OauthConfig::CONSUMER , OauthConfig::SECRET, {:site=>OauthConfig::SITE}
@request_token=@consumer.get_request_token
puts "Goto " + @request_token.authorize_url(:oauth_callback => OauthConfig::CALLBACK)
puts "press enter when login is successful"
gets
@access_token=@request_token.get_access_token
puts "Saving Access Token Details"
puts @access_token.token
puts @access_token.secret

file = File.open('access.token','w')
file.puts(@access_token.token)
file.puts(@access_token.secret)
