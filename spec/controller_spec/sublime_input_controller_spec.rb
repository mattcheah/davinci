require_relative '../../controllers/sublime_input_controller.rb'
require_relative '../../lib/utility.rb'

describe SublimeInputController do
    
    before do
       @controller = SublimeInputController.new("example_files/sublime/monokai.tmTheme") 
    end
    
    describe "new()" do
        it "reads the input file into a Nokogiri xml parsed object" do
            expect(@controller.instance_variable_get("@xml").class).to eq Nokogiri::XML::Document
        end
    end
    
    describe "parse_sublime_xml" do
        
        before do
            @controller.parse_input_files
        end
    
        it "parses the primary styles correctly" do
            expect(@controller.options[:foreground]).to eq "#F8F8F2"
            expect(@controller.options[:background]).to eq "#272822"
            expect(@controller.options[:comment_foreground]).to eq "#75715E"
            expect(@controller.options[:string_foreground]).to eq "#E6DB74"
            expect(@controller.options[:number_foreground]).to eq "#AE81FF"
        end
    
    end

end