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
        @options[:theme_name] = /name<\/key>.*?<string>(.*?)<\/string>/smx.match(@file)[1]
        @file = @file[@file.index(@options[:theme_name])..-1]
        
        settings_colors = ["background", "foreground", "caret", "invisibles", "lineHighlight", "selection", "findHighlight", "findHighlightForeground", "selectionBorder", "activeGuide", "bracketsForeground", "bracketContentsForeground", ]
        settings_style = ["bracketsOptions", "bracketContentsOptions", "tagsOptions"]
        
        settings_colors.each do |setting|
            @options[setting.to_sym] = /<key>settings<\/key>.*?<dict>.*?<key>#{setting}<\/key>.*?<string>(.*?)<\/string>/smx.match(@file)[1]
        end 
        
        settings_style.each do |setting|
            @options["#{setting}_style".to_sym] = /<key>settings<\/key>.*?<dict>.*?<key>#{setting}<\/key>.*?<string>(.*?)<\/string>/smx.match(@file)[1]
        end
        
        @file.scan(/<dict>.*?<key>name<\/key>.*?<string>(.*?)<\/string>.*?<dict>.*?<key>foreground<\/key>.*?<string>(.*?)<\/string>/mx) do |m|
            name = (m[0].underscore+"_foreground").to_sym
            @options[name] = m[1]
        end
        
        @file.scan(/<dict>.*?<key>name<\/key>.*?<string>(.*?)<\/string>.*?<dict>.*?<key>background<\/key>.*?<string>(.*?)<\/string>/mx) do |m|
            name = (m[0].underscore+"_background").to_sym
            @options[name] = m[1]
        end
        
         @file.scan(/<dict>.*?<key>name<\/key>.*?<string>(.*?)<\/string>.*?<dict>.*?<key>fontStyle<\/key>.*?<string>(.*?)<\/string>/mx) do |m|
            name = (m[0].underscore+"_font_style").to_sym
            @options[name] = m[1]
        end
       
        puts @options
    end
    
    def parse_atom_xml
    end
end

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-. ", "_").
    downcase
  end
end