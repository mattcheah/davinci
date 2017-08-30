# DaVinci-Text
Ruby command-line script to transfer your text-editor color scheme between the Sublime and Atom text editors. 

Support for Dreamweaver and Brackets to come.

## Installation / Setup

Install the gem the normal way:

    $ gem install davinci
    
You are now ready to use Davinci.

## Usage

After instaling davinci, run it by simply typing `davinci` in the command line and follow the instructions.
A command line prompt will show, asking you to choose the text editor you want to transfer your theme from. 

    What Text Editor are you currently using?
    (1) Sublime
    (2) Atom
    > 1

Enter 1 or 2 to select your text editor. The system will then ask for the theme file or theme folder. To figure out where this is, see the #Reference section.
You may also use the example_files directory, which contains the default Atom theme "Atom-Dark-Syntax", and the default Sublime theme "Monokai".  

    Enter the full filepath of your Sublime tmTheme syntax color file.
    If you do not know where this can be found, please read the documentation.
    > /example_files/sublime/monokai.tmTheme
    
Enter the path to your theme file or directory. The system will ask for an output text editor. At this point in development your only other option is the opposite of what you originally chose. 

    What editor would you like to move your color scheme to?
    (1) Sublime
    (2) Atom
    > 2
    
The system will output the parsed options into a theme template for your output text editor and place the file(s) into the /output/ folder. 
To add this newly created theme to your text editor, read the #Reference section. 

To exit at any time, press ctrl+c

## Warnings

## Reference


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattcheah/davinci. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the davinci project’s codebases is expected to follow the [code of conduct](https://github.com/mattcheah/davinci/blob/master/CODE_OF_CONDUCT.md).