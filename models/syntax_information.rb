class SyntaxInformation
   
    def initialize(filepath)
        if File.exists?(filepath)
            @file = File.read(filepath)
        else
            raise 
        end
        @options = {}
        @from_editor_specific_information = {}
    end
    
    def parse_sublime_xml
        #Parses all of the sublime xml document here into options and @from_editor_specific_information
        @options['theme_name'] = /name<\/key>.*?<string>(.*?)<\/string>/smx.match(@file)[1]
        
        @options['background_color'] = /<key>settings<\/key>.*?<dict>.*?<key>background<\/key>.*?<string>(.*?)<\/string>/smx.match(@file)[1]
        @options['foreground_color'] = /<key>settings<\/key>.*?<dict>.*?<key>foreground<\/key>.*?<string>(.*?)<\/string>/smx.match(@file)[1]
        puts @options
    end
    
    def parse_atom_xml
    end
end