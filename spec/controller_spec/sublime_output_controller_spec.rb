require_relative '../../controllers/sublime_output_controller.rb'
require_relative '../../controllers/sublime_input_controller.rb'
require_relative '../../lib/utility.rb'

require 'byebug'

describe SublimeOutputController do
    
    before do
        @options = {
            :theme_name=>"atom-dark-syntax",
            :foreground=>"#1d1f21",
            :background=>"#0E2231",
            :comment_foreground=>"#7C7C7C",
            :string_foreground=>"#EDEDED",
            :number_foreground=>"#FF73FD",
            :build_in_constant_foreground=>"#99CC99",
            :user_defined_constant_foreground=>"#99CC99",
            :variable_foreground=>"#C6C5FE",
            :keyword_foreground=>"#96CBFE",
            :entity_name_foreground=>"#62B1FE",
            :function_argument_foreground=>"#DAD085",
            :tag_name_foreground=>"#96CBFE",
            :tag_attribute_foreground=>"#C6C5FE",
            :function_call_foreground=>"#DAD085",
            :library_function_foreground=>"#DAD085",
        }
        
        gem_root = File.expand_path(__FILE__).split("/")[0..-4].join("/")
        @folderpath = "#{gem_root}/example_files/atom/atom-dark-syntax"
        
        @controller = SublimeOutputController.new(@options, @folderpath)
        @controller.duplicate_template_files
    end

    describe "duplicate_template_files" do
        
        it "moves template files to output/" do
            expect(File.exist?("#{@folderpath}/atom-dark-syntax/atom-dark-syntax.tmTheme"))
        end
    
    end
    
    describe "insert_styles" do
       
        before do
            @controller.insert_styles
            @input_controller = SublimeInputController.new("#{@folderpath}/atom-dark-syntax/atom-dark-syntax.tmTheme")
            @input_controller.parse_input_files
        end
      
        it "outputs the theme name" do
            expect(@input_controller.options[:theme_name]).to eq "atom-dark-syntax" 
        end
       
        it "parses the main colors" do  
            expect(@input_controller.options[:foreground]).to eq "#1d1f21"
            expect(@input_controller.options[:background]).to eq "#0E2231"
            expect(@input_controller.options[:comment_foreground]).to eq "#7C7C7C"
            expect(@input_controller.options[:string_foreground]).to eq "#EDEDED"
            expect(@input_controller.options[:number_foreground]).to eq "#FF73FD"
        end
        
    end

end