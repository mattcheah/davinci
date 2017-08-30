require 'nokogiri'
require 'open-uri'
require 'byebug'

class SublimeInputController 
    attr_reader :options
    
    def initialize(filepath)
        if File.exists?(filepath)
            file = File.read(filepath)
        else
            raise 
        end
        @xml = Nokogiri::XML(file)
        @options = {}
        # @from_editor_specific_information = {}
    end
    
    def parse_input_files
        @options[:theme_name] = @xml.xpath("//plist/dict/*[1]/following-sibling::string[1]/text()").text
        
        all_settings = @xml.xpath('//dict/array/dict')
        first_setting = all_settings.shift
        
        settings_keys = first_setting.xpath('./dict/key/text()')
        settings_values = first_setting.xpath('./dict/string/text()')
        settings_keys.each do |key|
            @options[key.text.underscore.to_sym] = settings_values.shift.text
        end
        
        all_settings.each do |setting|
            key = setting.xpath('./string[position()=1]/text()').text.underscore
            foreground_value = setting.xpath('./dict/key[text()="foreground"]/following-sibling::string[1]/text()').text
            background_value = setting.xpath('./dict/key[text()="background"]/following-sibling::string[1]/text()').text
            font_style_value = setting.xpath('./dict/key[text()="fontStyle"]/following-sibling::string[1]/text()').text
            
            
            @options["#{key}_foreground".to_sym] = foreground_value if foreground_value != ""
            @options["#{key}_background".to_sym] = background_value if background_value != ""
            @options["#{key}_font_style".to_sym] = font_style_value if font_style_value != ""
             
        end
        
        
        puts "done!"
        puts ""
        # pp @options
        
        
    end
    
end