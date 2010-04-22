gem 'oauth'
require 'OauthConfig'
require 'AccessToken'

at = AccessToken.new("profile")

file = File.open("image.jpg")

puts at.get("http://community.test.projektzion.se:80/community/images/" )
#puts at.get("http://localhost:8080/GrailsApplication2/upload/upload/" )