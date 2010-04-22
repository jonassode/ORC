class RestPage < Wx::Panel
  @at = ""

  def submit_form
    # Define Variables
    result = ""
    response = ""
    header = ""
    url = ""

    begin
      # Set Status
      $controller.set_status("Sending Request")

      # Set variables
      url = @url.get_label

      # REST Action
      response = case @radios.get_selection()
      when 0 then @at.get(url)
      when 1 then @at.put(url, [])
      when 2 then @at.post(url, [])
      when 3 then @at.delete(url)
      end

      # Save URL To Link List
      MyYaml.add(url,'urls')

      # Set Body - XML or HTML
      if response.content_type == "text/xml"
        doc = Document.new response.read_body
        doc.write(result, 4)
      else
        result = response.read_body
      end

      # Set Status
      header = "Status code: " + response.code.to_s + ", Content Type: " + response.content_type.to_s

    rescue StandardError => bang
      result = bang
      header = "Error"
    end
    @result.clear()
    @result.write_text( result.to_s )
    @result.set_insertion_point(0)
    $controller.set_status(header)
  end

  def build

    # Loading variables
    @at = AccessToken.new("profile")
    options = ["Get", "Put", "Post", "Delete"]   #labels for radio buttons
    urls = MyYaml.load('urls')

    # Create Elements
    @text = StaticText.new(self, -1, 'Rest', DEFAULT_POSITION, DEFAULT_SIZE)
    @radios = Wx::RadioBox.new(self,:label => "Method",:pos => DEFAULT_POSITION,:size => Wx::DEFAULT_SIZE,:choices => options,:major_dimension => 4,:style => Wx::RA_SPECIFY_COLS)
    @url_label = StaticText.new(self, -1, "URL:", DEFAULT_POSITION, DEFAULT_SIZE)
    @url = ComboBox.new(self, -1, '', DEFAULT_POSITION, DEFAULT_SIZE, urls, TE_PROCESS_ENTER )
    @button = Button.new(self, -1, 'Send', DEFAULT_POSITION, DEFAULT_SIZE)
    @result_label = StaticText.new(self, -1, "Result:", DEFAULT_POSITION, DEFAULT_SIZE)
    @result = TextCtrl.new(self, -1, '', DEFAULT_POSITION, DEFAULT_SIZE, TE_MULTILINE|TE_READONLY)

    # Register Events
    evt_button(@button) { submit_form() }
    evt_text_enter(@url) { submit_form() }

    # Place Elements
    @sizer = Wx::BoxSizer.new(Wx::VERTICAL)
    @sizer.add( @text, 0, Wx::GROW|Wx::ALL, 2)
    @sizer.add( @radios, 0, Wx::GROW|Wx::ALL, 2)
    @sizer.add( @url_label, 0, Wx::GROW|Wx::ALL, 2)
    @sizer.add( @url, 0, Wx::GROW|Wx::ALL, 2)
    @sizer.add( @button, 0, Wx::ALIGN_LEFT, 2)
    @sizer.add( @result_label, 0, Wx::GROW|Wx::ALL, 2)
    @sizer.add( @result, 1, Wx::GROW|Wx::ALL, 2)

    set_sizer(@sizer)
    show

    self
  end
end