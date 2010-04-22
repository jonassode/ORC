# Gem
gem 'oauth'

# WX
require "wx"
include Wx

# XML
require "rexml/document"
include REXML

# Oauth
require 'AccessToken'
require 'OauthConfig'

# ORC Gui
require 'MyNotebook'
require 'RestPage'
require 'OauthPage'
require 'ConfigPage'
require 'OrcTaskBarIcon'
require 'OrcIconMenu'
require 'OrcController'

# Yaml
require 'MyYaml'

# Global Controller
$controller = ""

class MainFrame < Wx::Frame
  @panel = ""

  def on_close_button
    $controller.shutdown
  end

  def initialize
    super(nil, :title => "Welcome to ORC ( Oauth Rest Client )", :pos => DEFAULT_POSITION, :size => [700, 500])

    # Register Events
    evt_close() { on_close_button() }
    evt_iconize() { |event| hide() }

    # Icon
    set_icon(Wx::Icon.new('orc.ico'))

    # Status Bar
    $controller.register_status_bar(StatusBar.new(self))
    $controller.set_status("ORC started without incident")

    # Task Bar Icon
    $controller.register_task_bar_icon(OrcTaskBarIcon.new().build)

    # Register Main Frame
    $controller.register_main_frame(self)

    # Main Panel
    @main_panel = Wx::Panel.new(self)

    # Creating Elements 
    notebook = MyNotebook.new(@main_panel, 1, DEFAULT_POSITION, DEFAULT_SIZE, NB_FIXEDWIDTH).build

    # Creating Sizers
    @main_panel.set_client_size(Wx::Size.new(9999, 9999))
    @sizer = Wx::BoxSizer.new(Wx::VERTICAL)

    # Place Elements
    @sizer.add(notebook, 1, Wx::GROW|Wx::ALL, 2)
    @sizer.add($controller.status_bar, 0, Wx::GROW|Wx::ALL, 2)

    set_sizer(@sizer)
  end
end

class MinimalApp < App
  def on_init
    MainFrame.new().show()
  end
end

# Creating Controller
$controller = OrcController.new()
$controller.start_app()



  