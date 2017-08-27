require 'fileutils'
require 'date'

class SublimeOutputController
   
    def initialize(options)
        @options = options
        @filename = "output/#{@options[:theme_name]}.tmTheme"
    end
    
    def duplicate_template_files
        current_dir = FileUtils.pwd
        
        FileUtils.rm_rf("output/.", secure: true)
        
        FileUtils.chmod(0755, "#{current_dir}/lib/templates/sublime/")
        FileUtils.chmod(0755, "#{current_dir}/output/")
        
        FileUtils.cp_r("#{current_dir}/lib/templates/sublime/.", "#{current_dir}/output/")
        FileUtils.mv("#{current_dir}/output/newTheme.tmTheme", "#{current_dir}/#{@filename}")
    end
    
    def insert_styles
        
        @base = File.read(@filename)
        replace_options
        clean_up_leftovers
        
        File.open(@filename, 'w') { |f| f.write(@base) }
        
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