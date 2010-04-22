require 'net/http/post/multipart'

class OAuth::Consumerx

    def create_http_request(http_method, path, *arguments)
      http_method = http_method.to_sym

      if [:post, :put].include?(http_method)
        data = arguments.shift
        data.reject! { |k,v| v.nil? } if data.is_a?(Hash)
      end

      headers = arguments.first.is_a?(Hash) ? arguments.shift : {}

      case http_method
      when :post_multi
        file = File.open('image.jpg')
        request = Net::HTTP::Post::Multipart.new(path, "file" => UploadIO.new(file, "image/jpeg", "image.jpg") )
        #request["Content-Length"] = 0 # Default to 0
      when :post
        request = Net::HTTP::Post.new(path,headers)
        request["Content-Length"] = 0 # Default to 0
      when :put
        request = Net::HTTP::Put.new(path,headers)
        request["Content-Length"] = 0 # Default to 0
      when :get
        request = Net::HTTP::Get.new(path,headers)
      when :delete
        request =  Net::HTTP::Delete.new(path,headers)
      when :head
        request = Net::HTTP::Head.new(path,headers)
      else
        raise ArgumentError, "Don't know how to handle http_method: :#{http_method.to_s}"
      end

      if data.is_a?(Hash)
        request.set_form_data(data); puts "a"
      elsif data
        if data.respond_to?(:read)
          request.body_stream = data; puts "b"
          if data.respond_to?(:length)
            request["Content-Length"] = data.length; puts "c"
          elsif data.respond_to?(:stat) && data.stat.respond_to?(:size)
            request["Content-Length"] = data.stat.size; puts "d"
          else
            raise ArgumentError, "Don't know how to send a body_stream that doesn't respond to .length or .stat.size"; puts "e"
          end
        else
          request.body = data.to_s; puts "d"
          request["Content-Length"] = request.body.length
        end
      else
        puts "f"
      end

      puts request

      request
    end

    def create_signed_request(http_method, path, token = nil, request_options = {}, *arguments)
      request = create_http_request(http_method, path, *arguments)
      sign!(request, token, request_options)
      puts request.to_s
      request
    end

    def request(http_method, path, token = nil, request_options = {}, *arguments)
      path_url = path
      if path !~ /^\//
        @http = create_http(path)
        _uri = URI.parse(path)
        path = "#{_uri.path}#{_uri.query ? "?#{_uri.query}" : ""}"
      end

      #rsp = http.request(create_signed_request(http_method, path, token, request_options, *arguments))
      url = URI.parse(path_url)
      http = Net::HTTP.start(url.host, url.port)
      req = create_signed_request(http_method, path, token, request_options, *arguments)
      rsp = http.request(req)

      # check for an error reported by the Problem Reporting extension
      # (http://wiki.oauth.net/ProblemReporting)
      # note: a 200 may actually be an error; check for an oauth_problem key to be sure
      if !(headers = rsp.to_hash["www-authenticate"]).nil? &&
        (h = headers.select { |h| h =~ /^OAuth / }).any? &&
        h.first =~ /oauth_problem/

        # puts "Header: #{h.first}"

        # TODO doesn't handle broken responses from api.login.yahoo.com
        # remove debug code when done
        params = OAuth::Helper.parse_header(h.first)

        # puts "Params: #{params.inspect}"
        # puts "Body: #{rsp.body}"

        raise OAuth::Problem.new(params.delete("oauth_problem"), rsp, params)
      end

      rsp
    end



end

class Net::HTTP::Post::Multipart

  def to_s
    puts "--"
    puts @header
    puts @body
    #puts @path
    #puts @response_has_body
    #puts @request_has_body
    puts @body_stream
    #puts @method
    puts "--"

  end

end