gem 'oauth'
require 'oauth/consumer'
require 'MyYaml'

class AccessToken
  @consumer
  @access_token
  @config

  def initialize()
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

  def get(url)
    # Doing Get and returning the response
    return @access_token.get(url)
  end

  def post(url, options)
    parameters = "?"
    options.each { |option|
      parameters = parameters + option[0] + "=" + option[1] + "&"
    }
    # Doing Post and returning the response
    return @access_token.post(url, options )
  end

  def delete(url)
    # Doing Delete and returning the response
    return @access_token.delete(url)
  end

end