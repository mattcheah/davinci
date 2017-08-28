require_relative '../../controllers/atom_output_controller.rb'
require_relative '../../lib/utility.rb'

require 'byebug'

describe AtomOutputController do
    
    before do
        @options = {
            :theme_name=>"Monokai",
            :background=>"#272822",
            :foreground=>"#F8F8F2",
            :comment_foreground=>"#75715E",
            :string_foreground=>"#E6DB74",
            :number_foreground=>"#AE81FF",
            :built_in_constant_foreground=>"#AE81FF",
            :user_defined_constant_foreground=>"#AE81FF",
            :keyword_foreground=>"#F92672",
            :entity_name_foreground=>"#A6E22E",
            :inherited_class_foreground=>"#A6E22E",
            :function_argument_foreground=>"#FD971F",
            :tag_name_foreground=>"#F92672",
            :tag_attribute_foreground=>"#A6E22E",
            :function_call_foreground=>"#66D9EF",
        }
        
        @controller = AtomOutputController.new(@options)
        @controller.duplicate_template_files
    end

    describe "duplicate_template_files" do
        
        before do
           FileUtils.rm_rf("output/.", secure: true) 
        end
        
        it "moves template files to output/" do
            expect(File.exist?("output/package.json"))
            expect(File.exist?("output/index.less"))
        end
    
    end
    
    describe "insert_styles" do
       
      before do
          @controller.insert_styles
      end
       
    #   it "parses the theme name" do
    #       expect(@controller.options[:theme_name]).to eq "atom-dark-syntax" 
    #   end
       
    #   it "parses the main colors" do  
    #       expect(@controller.options[:foreground]).to eq "#c5c8c6"
    #       expect(@controller.options[:background]).to eq "1d1f21asdasd"
    #       expect(@controller.options[:comment_foreground]).to eq "#7C7C7C"
    #       expect(@controller.options[:string_foreground]).to eq "#A8FF60"
    #       expect(@controller.options[:number_foreground]).to eq "#FF73FD"
    #   end
        
    end

end