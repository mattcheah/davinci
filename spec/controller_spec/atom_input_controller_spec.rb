require_relative '../../controllers/atom_input_controller.rb'
require_relative '../../lib/utility.rb'

describe AtomInputController do
    
    before do
        @controller = AtomInputController.new("example_files/atom")
    end

    describe ".new()" do
        
        it "combines all .less files into output.less" do
            expect File.exist?("../../example_files/atom/output.less")
        end
        
        it "reads the package.json file into a package variable" do
            expect(@controller.package).to_not eq ""
        end
    
    end
    
    describe ".parse_atom_less" do
       
       before do
           @controller.parse_atom_less
       end
       
       it "parses the theme name" do
          expect(@controller.options[:theme_name]).to eq "atom-dark-syntax" 
       end
       
       it "parses the main colors" do  
          expect(@controller.options[:foreground]).to eq "#c5c8c6"
          expect(@controller.options[:background]).to eq "1d1f21asdasd"
          expect(@controller.options[:comment_foreground]).to eq "#7C7C7C"
          expect(@controller.options[:string_foreground]).to eq "#A8FF60"
          expect(@controller.options[:number_foreground]).to eq "#FF73FD"
       end
        
    end

end