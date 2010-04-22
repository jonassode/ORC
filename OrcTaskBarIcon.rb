
class OrcTaskBarIcon < TaskBarIcon
  @menu

  def build

    # Set Icon
    icon = Icon.new()
    icon.load_file('orc.gif',BITMAP_TYPE_GIF)
    self.set_icon(icon,'ORC (Oauth Rest Client)')

    # Register Events
    evt_taskbar_left_dclick() { double_click() }

    @menu = OrcIconMenu.new().build

    self
  end

  def double_click
    $controller.show()
  end

  def create_popup_menu
    popup_menu(@menu)
    nil
  end



end
