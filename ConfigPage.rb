class ConfigPage < Wx::Panel

  def build
    # Create Elements
    text = StaticText.new(self, -1, 'Configure Page', DEFAULT_POSITION, DEFAULT_SIZE)

    # Place Elements
    @sizer = Wx::BoxSizer.new(Wx::VERTICAL)
    @sizer.add( text, 1, Wx::GROW|Wx::ALL, 2)

    set_sizer(@sizer)
    show

    self
  end

end