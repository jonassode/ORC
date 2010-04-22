require 'net/http/post/multipart'

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

url = URI.parse('http://localhost:8080/GrailsApplication2/upload/upload')
  jpg = File.open("image.jpg")
  req = Net::HTTP::Post::Multipart.new url.path, "file" => UploadIO.new(jpg, "image/jpeg", "image.jpg")
  puts req.to_s
  http = Net::HTTP.start(url.host, url.port)
  res = http.request(req)

  puts res
    

