class OauthPage < Wx::Panel
  @at = ""

  def build
    # Load AT
    @at = AccessToken.new("profile")

    # Create Elements
    welcome_text = StaticText.new(self, -1, 'Welcome to Oauth Page', DEFAULT_POSITION, DEFAULT_SIZE)
    token_label = StaticText.new(self, -1, "Token:", DEFAULT_POSITION, DEFAULT_SIZE)
    token = TextCtrl.new(self, -1, @at.token, DEFAULT_POSITION, DEFAULT_SIZE, TE_READONLY)
    secret_label = StaticText.new(self, -1, "Secret:", DEFAULT_POSITION, DEFAULT_SIZE)
    secret = TextCtrl.new(self, -1, @at.secret, DEFAULT_POSITION, DEFAULT_SIZE, TE_READONLY)

    # Place Elements
    @sizer = Wx::BoxSizer.new(Wx::VERTICAL)
    @sizer.add( welcome_text, 0, Wx::ALIGN_LEFT, 2)
    @sizer.add( token_label, 0, Wx::ALIGN_LEFT, 2)
    @sizer.add( token, 0, Wx::GROW|Wx::ALL, 2)
    @sizer.add( secret_label, 0, Wx::ALIGN_LEFT, 2)
    @sizer.add( secret, 0, Wx::GROW|Wx::ALL, 2)

    set_sizer(@sizer)
    show

    self
  end

end