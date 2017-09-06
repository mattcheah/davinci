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
        
        begin
            FileUtils.chmod(0755, "#{root_dir}/lib/templates/sublime/.")
            FileUtils.cp_r("#{root_dir}/lib/templates/sublime/", @new_dir)
            File.rename("#{@new_dir}newTheme.tmTheme", @filepath)
        rescue => e
            puts e
            puts "Try placing your theme file(s) inside a folder"
            exit
        end
        
        
    end
    
    def insert_styles
        
        @base = File.read(@filepath)
        replace_options
        clean_up_leftovers
        File.open(@filepath, 'w') { |f| f.write(@base) }
        
        puts "done!"
        puts "Sublime theme file created at #{@filepath}"
    end
    
    private

    def replace_options
        @options.each do |key, value|
            if value
                print "."
                @base.gsub!(/":::#{key.to_s}:::"/, value)
            end
        end
        
    end
    
    def clean_up_leftovers
        @base.gsub!(/":::.*?_font_style:::"/, "")
        @base.gsub!(/":::.*?_background:::"/, "")
        @base.gsub!(/":::.*?_foreground:::"/, @options[:foreground])
        @base.gsub!(/":::.*?:::"/, @options[:foreground])
    end
    
    
end