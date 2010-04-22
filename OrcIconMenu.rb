class OrcIconMenu < Menu

  def build
    # Show
    append(666, 'Show')
    evt_menu(666) { $controller.show() }
    # Exit
    append(Wx::ID_EXIT, 'Exit')
    evt_menu(Wx::ID_EXIT) { $controller.shutdown() }


    #evt_menu menu_item1, :on_do_something
    #my_menu.append(Wx::ID_OPEN, '&Open file', 'Open a file')
    # Handle this menu event, specifying by id
    self
  end
end