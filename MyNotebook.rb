class MyNotebook < Notebook

  def build
    add_page(RestPage.new(self).build, "REST", true)
    add_page(OauthPage.new(self).build, "Oauth", false)
    add_page(ConfigPage.new(self).build, "Configure", false)

    self
  end

end