# Start the command-line script with this file. 
require_relative "controllers/menu_controller.rb"

menu = MenuController.new()

menu.get_from_editor
