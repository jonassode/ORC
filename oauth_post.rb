gem 'oauth'
require 'OauthConfig'
require 'AccessToken'

at = AccessToken.new("profile")

puts at.post("http://user.test.projektzion.se/users/#{OauthConfig::USERID}/images",
  { "name" => "jonas", "description" => "urban", "tags" => "jonas",
    "sharing" => "community", "original" => "true", "community-editable" => "true",
    # "file" => File.open('image.jpg') }
    "fileUrl" => "http://www.chocosho.com/admin/images/380x285/79485_1_ninja.jpg" }

)

#            name,
#            description,
#            tags,
#            sharingLevel,
#            original,
#            communityEditable,
#            [[fileName:  imageName, contentType: contentType, parameterName: 'file']],
#            [
#             	[name:'application-tags', value:applicationTags]
#			]