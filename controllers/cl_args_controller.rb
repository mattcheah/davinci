require_relative './atom_input_controller.rb'
require_relative './atom_output_controller.rb'
require_relative './sublime_input_controller.rb'
require_relative './sublime_output_controller.rb'

module Davinci

    class ClArgsController
        def initialize(args)
           @args = args
           @filepath = clean_directory_path(@args[0])
        end
        
        def run
            
            input_controller = get_input_controller
            print "reading input file(s)"
            input_controller.parse_input_files
            output_controller = get_output_controller(@args[1], input_controller.options)
            output_controller.duplicate_template_files
            print "creating output file(s)"
            output_controller.insert_styles
           
        end
        
        def get_input_controller
            
            if @filepath[-8..-1] == ".tmTheme"
                begin
                    return SublimeInputController.new(@filepath)
                rescue => e
                    puts e
                    exit
                end
            else
                begin
                    return AtomInputController.new(@filepath)
                rescue => e
                    puts e
                    exit
                end
            end
            
        end
        
        def get_output_controller(output_editor, options)
            
            case output_editor
            when "atom"
                return AtomOutputController.new(options, @filepath)
            when "sublime"
                return SublimeOutputController.new(options, @filepath)
            else
                puts "Error: Davinci requires a second argument to know what text editor to output to."
                puts "eg. `davinci /example_files/atom sublime`"
                exit
            end
            
        end
    end

end