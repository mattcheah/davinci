require 'fileutils'
require 'date'

class AtomOutputController 
    attr_reader :options
    
    def initialize(options, filepath)
        @directory = filepath.split("/")[0..-2].join("/")
        @options = options
    end
    
    def duplicate_template_files
        current_dir = File.expand_path(__FILE__)
        root_dir = current_dir.split("/")[0..-3].join("/")
        @new_dir = "#{@directory}/#{@options[:theme_name]}/"
        
        if File.directory?(@new_dir)
            FileUtils.rm_rf(@new_dir, secure: true)
        end
        
        begin
            FileUtils.chmod(0755, "#{root_dir}/lib/templates/atom/")
            FileUtils.cp_r("#{root_dir}/lib/templates/atom/", @new_dir)
        rescue => e
            puts e
            puts "Try placing your theme file(s) inside a folder"
            exit
        end
        
        
    end
    
    def insert_styles
        read_files
        insert_package_info
        insert_syntax_variables
        write_base_info
        insert_changelog_info
        cleanup_leftovers
        
        File.open("#{@new_dir}/styles/base.less", 'w') { |f| f.write(@base) }
        File.open("#{@new_dir}/styles/syntax-variables.less", 'w') { |f| f.write(@syntax_variables) }
        puts "done!"
        puts "Atom theme files created at #{@new_dir}"
    end
    
    private
    
    def read_files
            @package = File.read("#{@new_dir}/package.json")
            @base = File.read("#{@new_dir}/styles/base.less")
            @syntax_variables = File.read("#{@new_dir}/styles/syntax-variables.less")
    end
    
    def insert_syntax_variables
        
        syntax_array = ["foreground", "background", "selection", "active_guide", "invisibles", "find_highlight", "diff_header_foreground", "diff_inserted_foreground", "diff_changed_foreground", "diff_deleted_foreground"]

        syntax_array.each do |opt|
            if @options.key?(opt.to_sym)
                print "."
                @syntax_variables.gsub!(/":::#{opt}:::"/, @options[opt.to_sym])
            end
        end
        
        
    end
    
    def insert_package_info
        print "."
        
        @package.gsub!(/:::theme_name:::/, "#{@options[:theme_name]}-syntax")
        File.open("#{@new_dir}/package.json", 'w') { |f| f.write(@package) }
    end
    
    def write_base_info
        
        # base_array = ["comment_foreground", "storage_foreground", "built_in_constant_foreground", "keyword_foreground", "language_variable_foreground", "function_argument_foreground", "invalid_deprecated_background", "invalid_deprecated_foreground", "string_foreground", "comment_foreground", "inherited_class_foreground", "function_call_foreground", "library_class_type_foreground", "inherited_class_foreground", "tag_name_foreground", "tag_attribute_foreground", "entity_name_foreground"]
        
        @options.keys.each do |key|
            print "."
            @base.gsub!(/":::#{key.to_s}:::"/, @options[key])
        end
        
        # base_array.each do |opt|
        #     print "."
        #     @base.gsub!(/":::#{opt}:::"/, @options[opt.to_sym])
        # end
    
        
    end
    
    def insert_changelog_info
        
        date = Date.today()
        
        changelog_text = "## 0.1.0 - First Release
*  #{@options[:theme_name]} Theme Translated to Atom on #{date.month}/#{date.mday}/#{date.year}, by DaVinci-Text (https://github.com/mattcheah/davinci)"
        
        File.open("#{@new_dir}/CHANGELOG.MD", "w") { |f| f.write(changelog_text) }
    end
    
    def cleanup_leftovers
        
        @base.gsub!(/":::.*?_font_style:::"/, "")
        @base.gsub!(/":::.*?_background:::"/, "")
        @base.gsub!(/":::.*?_foreground:::"/, @options[:foreground])
        @base.gsub!(/":::.*?:::"/, @options[:foreground])
        @syntax_variables.gsub!(/":::.*?:::"/, @options[:foreground])
        
    end
    
end

