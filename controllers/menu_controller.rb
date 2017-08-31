require_relative './atom_input_controller.rb'
require_relative './atom_output_controller.rb'
require_relative './sublime_input_controller.rb'
require_relative './sublime_output_controller.rb'

module Davinci

class MenuController
    def initialize
        puts "##### Color Scheme Translator #####"
        puts ""
        puts "Takes a XML/CSS/Less document from your text-editor that specifies syntax colors and outputs a formatted document that is compatible with the text editor you are switching to."

        @from_editor = ""
        @to_editor = ""

    end

    def start_menu

        puts ""
        puts "What Text Editor are you currently using?"
        puts "(1) Sublime"
        puts "(2) Atom"
        # puts "(3) Dreamweaver"
        # puts "(4) Brackets"

        get_from_editor
    end

    def get_from_editor(option = nil)
        if option
            selection = option
        else
            selection = gets.chomp
        end
        
        begin
        
            case selection
            when "1"
                @from_editor = "sublime"
                puts "Enter the full filepath of your Sublime tmTheme syntax color file."
                puts "If you do not know where this can be found, please read the documentation."
                @filepath = gets.chomp
                
                @input_controller = SublimeInputController.new(@filepath)
            when "2"
                @from_editor = "atom"
                puts "Enter the full filepath of your Atom theme directory"
                puts "If you do not know where this can be found, please read the documentation."
                @filepath = gets.chomp
                @filepath = @filepath[0..-2] if @filepath[-1] == "/"
                @input_controller = AtomInputController.new(@filepath)
            # when "3"
            #     @from_editor = "dreamweaver"
            #     puts "Enter the full filepath of your Dreamweaver _____ file."
            #     puts "If you do not know where this can be found, please read the documentation."
            #     @input_controller = DreamweaverInputController.new(gets.chomp)
            # when "4"
            #     @from_editor = "brackets"
            #     puts "Enter the full filepath of your Brackets _____ file."
            #     puts "If you do not know where this can be found, please read the documentation."
            #     @input_controller = BracketsInputController.new(gets.chomp)
            else
                puts "You did not choose one of the 2 options."
                start_menu
                return
            end
            
        rescue
            puts ""
            puts "This file path was not valid. Please enter your file path again."
            if @filepath[0] == "/"
                puts "Did you mean to include a / at the beginning of your path?"
            end
            return get_from_editor(selection)
            
        end

        parse_file
    end

    def parse_file
        print "parsing file"
        print "."
        @input_controller.parse_input_files

        get_to_editor

    end

    def get_to_editor
        puts ""
        puts "What editor would you like to move your color scheme to?"
        puts "(1) Sublime"
        puts "(2) Atom"
        # puts "(3) Dreamweaver"
        # puts "(4) Brackets"

        selection = gets.chomp

        case selection
        when "1"
            @to_editor = "sublime"
            @output_controller = SublimeOutputController.new(@input_controller.options, @filepath)
        when "2"
            @to_editor = "atom"
            @output_controller = AtomOutputController.new(@input_controller.options, @filepath)
        # when "3"
        #     @to_editor = "dreamweaver"
        # when "4"
        #     @to_editor = "brackets"
        else
            puts "You did not choose one of the 2 options."
            get_to_editor
            return
        end

        if @to_editor == @from_editor
            puts "That's the editor you started with! Pick a different editor."
            get_to_editor
            return
        end

        translate_to_output

    end

    def translate_to_output
        @output_controller.duplicate_template_files
        print  "inserting theme colors"
        @output_controller.insert_styles
        name = @output_controller.options[:theme_name]
        
        if @filepath[-8..-1] == ".tmTheme"
            @filepath = @filepath.split("/")[0..-2].join("/")
        end
        puts ""
        puts "Translation Complete! Your new theme is located in #{@filepath}/#{name}/"
    end
end

end