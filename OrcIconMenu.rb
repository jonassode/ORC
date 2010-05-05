class OrcIconMenu < Menu

  def build
    # Show
    append(666, 'Show')
    evt_menu(666) { $controller.show() }
    # Exit
    append(Wx::ID_EXIT, 'Exit')
    evt_menu(Wx::ID_EXIT) { $controller.shutdown() }

    self
  end
end