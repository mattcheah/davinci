

class MenuController
    def initialize
        puts "##### Color Scheme Translator #####"
        puts ""
        puts "Takes a XML/CSS/Less/JSON document from your text-editor that denotes syntax colors and outputs a formatted document that is compatible with the text editor you are switching to."
        @from_editor = ""
        @to_editor = ""
    end
    
    def start_menu
        
        puts ""
        puts "What Text Editor are you currently using?"
        puts "1. Sublime"
        puts "2. Dreamweaver"
        puts "3. Atom"
        puts "4. Brackets"
        
        gets.chomp
    end
    
    def get_from_editor 
        selection = start_menu
        case selection
        when "1"
            puts "Sublime."
            @from_editor = "sublime"
        when "2"
            puts "Dreamweaver."
            @from_editor = "dreamweaver"
        when "3"
            puts "Atom."
            @from_editor = "atom"
        when "4"
            puts "Brackets."
            @from_editor = "brackets"
        else
            puts "You did not choose one of the 4 options."
            get_from_editor
        end
        
    end
end