gem 'oauth'
require 'oauth/consumer'
require 'MyYaml'
#require 'extensions'

class AccessToken
  @consumer
  @access_token
  @config

  def initialize(profile)
    # Reading Access Details from file

    @config = MyYamlHash.load('oauthconfig')

    # Create Access Token
    @consumer = OAuth::Consumer.new @config['consumer_id'] , @config['consumer_secret'], { :site=>@config['site'] }
    @access_token = OAuth::AccessToken.new(@consumer, @config['access_token'], @config['access_token_secret'])
  end

  def token
    @config['access_token']
  end

  def secret
    @config['access_token_secret']
  end

  def put(url, options)
    # Building Parameters String
    parameters = "?"
    options.each { |option|
      parameters = parameters + option[0] + "=" + option[1] + "&"
    }
    # Doing Put and returning the response
    return @access_token.put(url + parameters)
  end

  def get(url, *options)
    # Doing Get and returning the response
    # puts "-->" +  url
    # return @access_token.request(:post_multi, url, options )
    return @access_token.get(url)
  end

  def post(url, options)
    parameters = "?"
    options.each { |option|
      parameters = parameters + option[0] + "=" + option[1] + "&"
    }
    puts @consumer.http.class
    # Doing Post and returning the response
    return @access_token.post(url, options )
  end

  def delete(url)
    # Doing Delete and returning the response
    return @access_token.delete(url)
  end

end