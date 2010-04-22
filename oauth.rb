gem 'oauth'
require 'oauth/consumer'
require 'OauthConfig'
require 'MyYaml'

@config = MyYamlHash.load('oauthconfig')
@consumer=OAuth::Consumer.new @config['consumer_id'] , @config['consumer_secret'], { :site=>@config['site'] }
@request_token=@consumer.get_request_token
puts "Goto " + @request_token.authorize_url(:oauth_callback => @config['callback'])
puts "press enter when login is successful"
gets
@access_token=@request_token.get_access_token
puts "Saving Access Token Details"
puts @access_token.token
puts @access_token.secret

#file = File.open('access.token','w')
#file.puts(@access_token.token)
#file.puts(@access_token.secret)

@config['access_token'] = @access_token.token
@config['access_token_secret'] = @access_token.secret
MyYamlHash.save(@config, 'oauthconfig')
