require_relative 'atom_controller.rb'
require_relative 'sublime_controller.rb'

require_relative '../models/syntax_information.rb'


class MenuController
    def initialize
        puts "##### Color Scheme Translator #####"
        puts ""
        puts "Takes a XML/CSS/Less/JSON document from your text-editor that specifies syntax colors and outputs a formatted document that is compatible with the text editor you are switching to."
        
        @from_editor = ""
        @to_editor = ""
        
    end
    
    def start_menu
        
        puts ""
        puts "What Text Editor are you currently using?"
        puts "(1) Sublime"
        puts "(2) Dreamweaver"
        puts "(3) Atom"
        puts "(4) Brackets"
        
        get_from_editor
    end
    
    def get_from_editor 
        # selection = gets.chomp
        # case selection
        # when "1"
        #     @from_editor = "sublime"
        #     puts "Enter the full filepath of your Sublime tmTheme syntax color file."
        # when "2"
        #     puts "Enter the full filepath of your Dreamweaver _____ file."
        #     @from_editor = "dreamweaver"
        # when "3"
        #     puts "Enter the full filepath of your Atom _____ file."
        #     @from_editor = "atom"
        # when "4"
        #     puts "Enter the full filepath of your Brackets _____ file."
        #     @from_editor = "brackets"
        # else
        #     puts "You did not choose one of the 4 options."
        #     start_menu
        #     return
        # end
        
        # puts "If you do not know where this can be found, please read the documentation."
        # get_file
        @from_editor = "sublime"
        @syntax = SyntaxInformation.new("example_files/monofly.tmTheme")
        
        parse_file
    end
    
    def get_file
        begin 
            @syntax = SyntaxInformation.new(gets.chomp)
        rescue 
            puts "This file path was not valid. P@ease enter your file path again."
            return get_file
        end
        
        parse_file
    end
    
    def parse_file
        print "parsing file"      
        print "."
        case @from_editor
        when "sublime"
            @syntax.parse_sublime_xml
        when "atom"
            @syntax.parse_atom_xml
        end
        
        get_to_editor
        
    end
    
    def get_to_editor
        puts "What editor would you like to move your color scheme to?"
        puts "(1) Sublime"
        puts "(2) Dreamweaver"
        puts "(3) Atom"
        puts "(4) Brackets"
        
        selection = gets.chomp
        
        case selection
        when "1"
            @to_editor = "sublime"
            output_controller = SublimeController.new(@syntax.options) 
        when "2"
            @to_editor = "dreamweaver"
        when "3"
            @to_editor = "atom"
            output_controller = AtomController.new(@syntax.options) 
        when "4"
            @to_editor = "brackets"
        else
            puts "You did not choose one of the 4 options."
            get_to_editor
            return
        end
        
        if @to_editor == @from_editor
            puts "That's the editor you started with! Pick a different editor."
            get_to_editor
            return
        end        
    end
end