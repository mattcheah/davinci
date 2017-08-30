# Start the command-line script with this file. 
require_relative "controllers/menu_controller.rb"
require "utility.rb"
require "version.rb"

module DaVinciText
    menu = MenuController.new()
    menu.start_menu
end

