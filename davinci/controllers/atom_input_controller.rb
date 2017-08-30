require "pp"

class AtomInputController
    attr_accessor :options
  
    def initialize(directory_path)
        directory_path = directory_path[0..-2] if directory_path[-1] == "/"
          
        @directory_path = directory_path
        @package = File.read("#{@directory_path}/package.json")
        @options = {}
        @color_hash = {}
        `coyote '#{@directory_path}/index.less:#{@directory_path}/output.less'`
    end
     
    def parse_input_files

      @base = File.read("#{@directory_path}/output.less")

      get_theme_name
      parse_colors
      get_base_options
 
      puts "done!"
      puts ""
      # puts "options:"
      # pp @options

    end

    private
    
    def get_theme_name
      @package.scan(/"name":\s"(.*?)"\,.*?"theme":\s"syntax"/mx) do |m|
        @options[:theme_name] = m[0]
      end
    end

    def parse_colors

      @base.scan(/^(@.*):\s+(.*);$/x) do |m|
        
        if m[1][0] == "@"
          color = @color_hash[m[1].underscore.to_sym]
        else
          color = m[1]
        end
        
        # Match an @sign followed by a color name, then 0 or more spaces, then a pound sign with the color hex value.
        @color_hash[m[0].underscore.to_sym] = color
        print "."
      end
      
    end

    def get_base_options
      
        parse_options = {
          foreground: /atom-text-editor.*?^\s*[^background-]color:\s*(.*?);.*?}/mx,
          background: /atom-text-editor.*?background-color:\s*(.*?);/mx,
          caret: /atom-text-editor.*?\s*cursor\s*{.*?color:\s*(.*?);/mx,
          invisibles: /atom-text-editor.*?invisible-character.*?\{.*?color:\s*(.*?)/mx,
          line_highlight: /\.line-number\.cursor-line.*?\{.*?background-color:\s*(.*?);/mx,
          selection: /\.selection.*?\.region\s*?{.*?color:\s*(.*?);/mx,
          brackets_foreground: /\.bracket-matcher\s*?\.region.*?border-bottom:\s*?[0-9]*px\s*?(?:solid|dotted|dashed)\s+?(.*?);/mx,
          bracket_contents_foreground: /\.bracket-matcher\s*?\.region.*?border-bottom:\s*?[0-9]*px\s*?(?:solid|dotted|dashed)\s+?(.*?);/mx,
          comment_foreground: /\.syntax--comment.*?\{.*?color:\s*(.*?);/mx,
          string_foreground: /^\.syntax--string\s*{\n?\s+color:\s*(.*?);$/mx,
          number_foreground: /\.syntax--constant.*?syntax--numeric.*?\{.*?color:\s*(.*?);/mx,
          build_in_constant_foreground: /\.syntax--constant.*?\{.*?color:\s*(.*?);/mx,
          user_defined_constant_foreground: /\.syntax--constant.*?\{.*?color:\s*(.*?);/mx,
          variable_foreground: /\.syntax--variable.*?\{.*?color:\s*(.*?);/mx,
          keyword_foreground: /\.syntax--keyword.*?\{.*?color:\s*(.*?);/mx,
          storage_foreground: /\.syntax--storage.*?\.syntax--modifier.*?\{.*?color:\s*(.*?);/mx,
          storage_type_foreground: /\.syntax--storage.*?\{.*?color:\s*(.*?);/mx,
          entity_name_foreground: /^\.syntax--entity.*?color:\s*(.*?);/mx,
          function_argument_foreground: /syntax--support.*?\{.*?color:\s*(.*?);/mx,
          tag_name_foreground: /\.syntax--entity\.syntax--name\.syntax--tag.*?{.*?color:\s*(.*?);/mx,
          tag_attribute_foreground: /\.syntax--other\.syntax--attribute-name.*?\{.*?color:\s*(.*?);/mx,
          function_call_foreground: /syntax--function.*?\{.*?color:\s*(.*?);.*?\}/mx,
          library_function_foreground: /syntax--function.*?\{.*?color:\s*(.*?);/mx,
          library_class_type_foreground: /syntax--support\s*\{.*?color:\s*(.*?);/mx,
          invalid_foreground: /syntax--illegal.*?\{.*?color:\s*(.*?);/mx,
          invalid_background: /syntax--illegal.*?\{.*?background-color:\s*(.*?);/mx,
        }
        
        parse_options.each do |key, value|
          
        	color = get_hex_value(@base.match(value))
        	
        	@options[key] = color
        # 	puts "#{key.to_s}: #{color}"
        
        end
        
        
        return @options
    end

    def get_hex_value(options_match)
        if options_match
          if options_match[1][0] == '@'
              return @color_hash[options_match[1].underscore.to_sym]
          else
              return options_match[1]
          end
        end
    end
end