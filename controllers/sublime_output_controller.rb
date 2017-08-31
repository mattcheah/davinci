require 'fileutils'
require 'date'

class SublimeOutputController
    
    attr_reader :options
   
    def initialize(options, filepath)
        @options = options
        @directory = filepath
        @filename = "#{@options[:theme_name]}.tmTheme"
    end
    
    def duplicate_template_files
        
        current_dir = File.expand_path(__FILE__)
        root_dir = current_dir.split("/")[0..-3].join("/")
        @new_dir = "#{@directory}/#{@options[:theme_name]}/"
        @filepath = "#{@new_dir}#{@filename}"
        
        if File.directory?(@new_dir)
            FileUtils.rm_rf(@new_dir, secure: true)
        end
        
        FileUtils.chmod(0755, "#{root_dir}/lib/templates/sublime/.")
        FileUtils.cp_r("#{root_dir}/lib/templates/sublime/", @new_dir)

        File.rename("#{@new_dir}newTheme.tmTheme", @filepath)
        
        # THIS WILL NEVER WORK. 
    end
    
    def insert_styles
        
        @base = File.read(@filepath)
        replace_options
        clean_up_leftovers
        File.open(@filepath, 'w') { |f| f.write(@base) }
        
        puts "done!"
    end
    
    private

    def replace_options
        @options.each do |key, value|
            print "."
            @base.gsub!(/":::#{key.to_s}:::"/, value)
        end
        
    end
    
    def clean_up_leftovers
        @base.gsub!(/":::.*?_font_style:::"/, "")
        @base.gsub!(/":::.*?_background:::"/, "")
        @base.gsub!(/":::.*?_foreground:::"/, @options[:foreground])
        @base.gsub!(/":::.*?:::"/, @options[:foreground])
    end
    
    
end