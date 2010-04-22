gem 'oauth'
require 'OauthConfig'
require 'AccessToken'

at = AccessToken.new("profile")

puts at.put("http://user.test.projektzion.se/users/#{OauthConfig::USERID}/images/1269606785585", {"description"=>""})

