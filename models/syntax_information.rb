class SyntaxInformation
   
    def initialize(filepath)
        @file = File.read(filepath)
        @options = {}
        @from_editor_specific_information = {}
    end
    
    def parse_sublime_xml(document)
        #Parses all of the sublime xml document here into options and @from_editor_specific_information
    end
end