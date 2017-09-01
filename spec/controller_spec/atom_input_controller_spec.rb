require_relative '../../controllers/atom_input_controller.rb'
require_relative '../../lib/utility.rb'

describe AtomInputController do
    
    before do
        # @atom_dark_controller = AtomInputController.new("example_files/atom/atom-dark-syntax")
        @loved_controller = AtomInputController.new("example_files/atom/loved-syntax")
    end

    describe ".new()" do
        
        it "combines all .less files into output.less" do
            # expect File.exist?("../../example_files/atom/atom-dark-syntax/output.less")
            expect File.exist?("../../example_files/atom/loved-syntax/output.less")
        end
        
        it "reads the package.json file into a package variable" do
            # expect(@atom_dark_controller.instance_variable_get("@package")).to_not eq ""
            expect(@loved_controller.instance_variable_get("@package")).to_not eq ""
        end
    
    end
    
    describe "parse_input_files" do
       
       before do
        #   @atom_dark_controller.parse_input_files
           @loved_controller.parse_input_files
       end
       
       it "parses the theme name" do
        #   expect(@atom_dark_controller.options[:theme_name]).to eq "atom-dark-syntax" 
          expect(@loved_controller.options[:theme_name]).to eq "loved-syntax" 
       end
       
       it "parses the main colors" do  
        #   expect(@atom_dark_controller.options[:foreground]).to eq "#c5c8c6"
        #   expect(@atom_dark_controller.options[:background]).to eq "#1d1f21"
        #   expect(@atom_dark_controller.options[:comment_foreground]).to eq "#7C7C7C"
        #   expect(@atom_dark_controller.options[:string_foreground]).to eq "#A8FF60"
        #   expect(@atom_dark_controller.options[:number_foreground]).to eq "#FF73FD"
          
          expect(@loved_controller.options[:foreground]).to eq "hsl(219, 13%, 78%)"
          expect(@loved_controller.options[:background]).to eq "hsl(218, 35%, 14%)"
          expect(@loved_controller.options[:comment_foreground]).to eq "hsl(206, 11%, 44%)"
          expect(@loved_controller.options[:string_foreground]).to eq "hsl(96, 10%, 60%)"
          expect(@loved_controller.options[:number_foreground]).to eq "hsl(27, 65%, 76%)"
       end
        
    end

end