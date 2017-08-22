

class AtomInputController
    def initialize(directory_path)
        @directory_path = directory_path
      `coyote '#{@directory_path}/index.less:#{@directory_path}/output.less'`
    end
     
    def parse_atom_less
      # base, syntax_variables, colors, package = get_atom_files

      # @color_hash = {}
      # parse_colors(colors)
      # parse_syntax_variables(syntax_variables)

      # @options = get_base_options(base, color_hash)

      # package.scan(/"name":\s"(.*?)"\,.*?"theme":\s"syntax"/mx) do |m|
      #   @options[:theme_name] = m[1]
      # end

    end

    private

    # def get_atom_files
    #     base = File.read("#{@directory_path}/styles/base.less")
    #     syntax_variables = File.read("#{@directory_path}/styles/syntax_variables.less")
    #     package = File.read("#{@directory_path}/package.json")

    #     [base, syntax_variables, colors, package]
    # end

    def parse_colors(colors)

      # @very-light-gray: #c5c8c6;
      # @light-gray: #969896;

      colors.split('\n')
      colors.each do |line|
        # Match an @sign followed by a color name, then 0 or more spaces, then a pound sign with the color hex value.
        m = /(@.*):\s+(\#.*);/mx.match(line)
        @color_hash[m[0].underline.to_sym] = m[1]
      end

    end

    def parse_syntax_variables(syntax_variables)

      syntax_variables.split('\n')
      syntax_variables.each do |line|

        # Match an @sign followed by a color name, then 0 or more spaces, then a pound sign with the color hex value OR @ sign with color name.
        m = /(@.*):\s+([#|@].*);/mx.match(line)
        if m[1][0] == "@"
            if @color_hash[m[1]].exists?
              @color_hash[m[0].underline.to_sym] = @color_hash[m[1]]
            end
        else
          @color_hash[m[0].underline.to_sym] = m[1]
        end
      end

    end

    def get_base_options(base)
        # atom-text-editor {
        #   background-color: @syntax-background-color;
        #   color: @syntax-text-color;
        @options['background'] = get_hex_value(/atom-text-editor\s+\{.*?background-color:\s+(.*);/mx.match(base))
        @options['foreground'] = get_hex_value(/atom-text-editor\s+\{.*?;\ncolor:\s+(.*);/mx.match(base))
        # more regex goes here to match every single element... maybe.
        puts "options"
        puts @options
    end

    def get_hex_value(match)
        if match[0] == '@'
            @color_hash[match[0]]
        else
            match[0]
        end
    end
end