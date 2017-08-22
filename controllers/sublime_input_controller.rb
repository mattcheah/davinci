

class Sublime_Input_Controller 
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
            @options[setting.underscore.to_sym] = /<key>settings<\/key>.*?<dict>.*?<key>#{setting}<\/key>.*?<string>(.*?)<\/string>/smx.match(@file)[1]
            print "."
        end 
        
        settings_style.each do |setting|
            @options["#{setting.underscore}_style".to_sym] = /<key>settings<\/key>.*?<dict>.*?<key>#{setting}<\/key>.*?<string>(.*?)<\/string>/smx.match(@file)[1]
            print "."
        end
        
        @file.scan(/<dict>.*?<key>name<\/key>.*?<string>(.*?)<\/string>.*?<dict>.*?<key>foreground<\/key>.*?<string>(.*?)<\/string>/mx) do |m|
            name = (m[0].underscore+"_foreground").to_sym
            @options[name] = m[1]
            print "."
        end
        
        @file.scan(/<dict>.*?<key>name<\/key>.*?<string>(.*?)<\/string>.*?<dict>.*?<key>background<\/key>.*?<string>(.*?)<\/string>/mx) do |m|
            name = (m[0].underscore+"_background").to_sym
            @options[name] = m[1]
            print "."
        end
        
         @file.scan(/<dict>.*?<key>name<\/key>.*?<string>(.*?)<\/string>.*?<dict>.*?<key>fontStyle<\/key>.*?<string>(.*?)<\/string>/mx) do |m|
            name = (m[0].underscore+"_font_style").to_sym
            @options[name] = m[1]
            print "."
        end
        puts "done!"
        
    end
    
end