require_relative '../../controllers/atom_output_controller.rb'
require_relative '../../controllers/atom_input_controller.rb'
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
        
        gem_root = File.expand_path(__FILE__).split("/")[0..-4].join("/")
        @folderpath = "#{gem_root}/example_files/sublime"
        filepath = "#{gem_root}/example_files/sublime/monokai.tmTheme"
        
        @controller = AtomOutputController.new(@options, filepath)
        @controller.duplicate_template_files
    end

    describe "duplicate_template_files" do

        it "moves template files to [THEME NAME] folder in the same directory" do
            expect(File.exist?("#{@folderpath}/Monokai/package.json"))
            expect(File.exist?("#{@folderpath}/Monokai/index.less"))
        end
    
    end
    
    describe "insert_styles" do
       
        before do
            @controller.insert_styles
            @input_controller = AtomInputController.new("#{@folderpath}/Monokai/")
            @input_controller.parse_input_files
        end
      
      
        it "outputs the theme name" do
            expect(@input_controller.options[:theme_name]).to eq "Monokai-syntax" 
        end
       
        it "parses the main colors" do  
            expect(@input_controller.options[:foreground]).to eq "#F8F8F2"
            expect(@input_controller.options[:background]).to eq "#272822"
            expect(@input_controller.options[:comment_foreground]).to eq "#75715E"
            expect(@input_controller.options[:string_foreground]).to eq "#E6DB74"
            expect(@input_controller.options[:number_foreground]).to eq "#AE81FF"
        end
        
    end

end