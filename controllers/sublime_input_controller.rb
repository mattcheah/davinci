require 'nokogiri'
require 'open-uri'
require 'byebug'

class SublimeInputController 
    attr_reader :options
    
    def initialize(filepath)
        
        if File.exists?(filepath)
            file = File.read(filepath)
        else
            raise "Error: Sublime File does not exist at path: #{filepath}"
        end
        @xml = Nokogiri::XML(file)
        @options = {}
        # @from_editor_specific_information = {}
    end
    
    def parse_input_files
        
        all_settings = @xml.xpath('//dict/array/dict')
        
        get_primary_settings(all_settings.shift)
        get_secondary_settings(all_settings)
        
        cleanup_stragglers
        
        puts "done!"
        puts ""
        # pp @options
        
    end
    
    
    
    private
    
    
    
    def get_primary_settings(first_setting)
        @options[:theme_name] = @xml.xpath("//plist/dict/key[text()='name']/following-sibling::string[1]/text()").text
        
        settings_keys = first_setting.xpath('./dict/key/text()')
        settings_values = first_setting.xpath('./dict/string/text()')

        settings_keys.each do |key|
            print "."
            @options[key.text.underscore.to_sym] = settings_values.shift.text
        end
    end
    
    def get_secondary_settings(all_settings)
        
        all_settings.each do |setting|
            print "."
            foreground_value = setting.xpath('./dict/key[text()="foreground"]/following-sibling::string[1]/text()').text
            background_value = setting.xpath('./dict/key[text()="background"]/following-sibling::string[1]/text()').text
            font_style_value = setting.xpath('./dict/key[text()="fontStyle"]/following-sibling::string[1]/text()').text
            
            key = setting.xpath('./string[position()=1]/text()').text
        
            if key.index(",")
                key.gsub!(/\s/, "")
                key = key.split(",")
                key.each do |sub_key|
                    sub_key = sub_key.underscore
                    @options["#{sub_key}_foreground".to_sym] = foreground_value if foreground_value != ""
                    @options["#{sub_key}_background".to_sym] = background_value if background_value != ""
                    @options["#{sub_key}_font_style".to_sym] = font_style_value if font_style_value != ""
                end     
            else 
                @options["#{key.underscore}_foreground".to_sym] = foreground_value if foreground_value != ""
                @options["#{key.underscore}_background".to_sym] = background_value if background_value != ""
                @options["#{key.underscore}_font_style".to_sym] = font_style_value if font_style_value != ""
            end
        end
    end
    
    def cleanup_stragglers
       #Some funky situations make this douche of a method to be necessary for renaming options that are enacted using scope that doesn't match the name, etc.
       
       #rename options hash:
       rename = {
           :comments_foreground => :comment_foreground,
       }
       
       rename.each do |key, value|
          
           if @options.has_key?(key)
               @options[value] = @options[key]
           end
       end
       
    end
    
end