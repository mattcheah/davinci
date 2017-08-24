# Start the command-line script with this file. 
require_relative "controllers/menu_controller.rb"
require_relative "lib/utility.rb"

menu = MenuController.new()

menu.start_menu

