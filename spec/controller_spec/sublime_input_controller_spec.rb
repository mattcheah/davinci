require_relative '../../controllers/sublime_input_controller.rb'
require_relative '../../lib/utility.rb'

describe SublimeInputController do
    
    before do
       @monokai_controller = SublimeInputController.new("example_files/sublime/monokai.tmTheme") 
       @material_controller = SublimeInputController.new("example_files/sublime/material.tmTheme") 
    end
    
    describe "new()" do
        it "reads the input file into a Nokogiri xml parsed object" do
            expect(@monokai_controller.instance_variable_get("@xml").class).to eq Nokogiri::XML::Document
            expect(@material_controller.instance_variable_get("@xml").class).to eq Nokogiri::XML::Document
        end
    end
    
    describe "parse_input_files" do
        
        before do
            @monokai_controller.parse_input_files
            @material_controller.parse_input_files
        end
    
        it "parses the primary styles correctly" do
            byebug
            expect(@monokai_controller.options[:foreground]).to eq "#F8F8F2"
            expect(@monokai_controller.options[:background]).to eq "#272822"
            expect(@monokai_controller.options[:comment_foreground]).to eq "#75715E"
            expect(@monokai_controller.options[:string_foreground]).to eq "#E6DB74"
            expect(@monokai_controller.options[:number_foreground]).to eq "#AE81FF"
            
            expect(@material_controller.options[:foreground]).to eq "#eeffff"
            expect(@material_controller.options[:background]).to eq "#263238"
            expect(@material_controller.options[:comment_foreground]).to eq "#546E7A"
            expect(@material_controller.options[:string_foreground]).to eq "#C3E88D"
            expect(@material_controller.options[:number_foreground]).to eq "#F78C6C"
        end
    
    end

end