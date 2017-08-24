require "pp"

class AtomInputController
    def initialize(directory_path)
        @directory_path = directory_path
        `coyote '#{@directory_path}/index.less:#{@directory_path}/output.less'`
    end
     
    def parse_atom_less
      package = File.read("#{@directory_path}/package.json")
  
      @base = File.read("#{@directory_path}/output.less")
      @options = {}
      @color_hash = {}
      parse_colors
      

      @options = get_base_options

      # package.scan(/"name":\s"(.*?)"\,.*?"theme":\s"syntax"/mx) do |m|
      #   @options[:theme_name] = m[0]
      # end
      puts "done!"
      puts ""
      puts "options:"
      pp @options

    end

    private

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
      
      # puts "color_hash: "
      # pp @color_hash

      # colors.split('\n')
      # colors.each do |line|
      #   m = /(@.*):\s+(\#.*);/mx.match(line)
      #   @color_hash[m[0].underline.to_sym] = m[1]
      # end

    end

    def get_base_options
        
        @options[:background] = get_hex_value(/atom-text-editor\s+\{.*?background-color:\s+(.*?);/mx.match(@base))
        @options[:foreground] = get_hex_value(/atom-text-editor\s+\{.*?;.*?color:\s+(.*?);/mx.match(@base))
        # more regex goes here to match every single element... maybe.
        return @options
    end

    def get_hex_value(options_match)
        if options_match[1][0] == '@'
            return @color_hash[options_match[1].underscore.to_sym]
        else
            return options_match[1]
        end
    end
end