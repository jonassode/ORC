gem 'oauth'
require 'OauthConfig'
require 'AccessToken'

at = AccessToken.new("profile")

puts at.delete("http://user.test.projektzion.se/users/#{OauthConfig::USERID}/images/1269606785585")

