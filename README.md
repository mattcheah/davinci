# DaVinci-Text

![alt text](https://circleci.com/gh/mattcheah/davinci.svg?style=shield&circle-token=5a1e0343c196170c3abe3387d7014657fef4b700 "")

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

Enter 1 or 2 to select your text editor. The system will then ask for the theme file or theme folder. 
To figure out where this is, see the [Reference section](https://github.com/mattcheah/davinci/blob/master/REFERENCE.md).
You may also use the example_files directory, which contains the default Atom theme "Atom-Dark-Syntax", and the default Sublime theme "Monokai".  

    Enter the full filepath of your Sublime tmTheme syntax color file.
    If you do not know where this can be found, please read the documentation.
    > /example_files/sublime/monokai.tmTheme
    
Enter the path to your theme file or directory. The system will ask for an output text editor.

    What editor would you like to move your color scheme to?
    (1) Sublime
    (2) Atom
    > 2
    
The system will output the parsed options into a theme template for your output text editor and place the file(s) into the /output/ folder. 
To add this newly created theme to your text editor, read the [Reference section](https://github.com/mattcheah/davinci/blob/master/REFERENCE.md). 

To exit the program any time, press ctrl+c

## Warnings

Theme files are parsed by an XML Parser or by Regex. Both of these parsing methods can be potentially unreliable depending on the scopes assigned to the colors in the Sublime XML file, or the combination of Less selectors in the Atom combined file. 

This is further complicated by the fact that editors do not always categorize the same code in the same way. As an example, the `System` in the following Java code

    System.out.println("Hello World!");

is categorized in Sublime as a "Storage Type" keyword, usually reserved for keywords that affect the storage of an item (eg. __void__ in Java). However, in Atom, `System` is given the classes `"syntax--variable syntax--other syntax--object syntax--java"`. The most common of these classes would be `syntax--variable`, meaning that even if colors from other classes are parsed (they're not), the color would not necessarily show up the same when transferring between Atom and Sublime.  

All this to say that the process is unstable and you may have to do a little bit of clean-up work on your resulting theme-files. I have found, however, that the overall look and feel of the theme is preserved.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattcheah/davinci. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### Support for new editors

Contributors who would like to add support for a new editor should make sure their pull requests contain the following: 
* An Excel or CSV file adding a selector column for their new editor to the [reference sheet](https://docs.google.com/spreadsheets/d/1DqhOP7L2ApQSOU6tKnh1Bx-92pzY7-BJK2Yccf6wr-c/edit?usp=sharing). 
* A controller for inputting and/or outputting hex codes to/from the options hash.
* Rspec tests
    * Input Controllers: Tests should confirm that an options hash contains the correct colors for the primary theme styles (:foreground, :background, :comment_foreground, :string_foreground, etc)
    * Output Controllers: Tests should confirm that the colors from a given options hash show up correctly in the outputted file(s). If an input controller is provided, it can be used to confirm this. If not, the outputted file must be parsed manually. 
* Updates to MenuController to include functionality.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the davinci project’s codebases is expected to follow the [code of conduct](https://github.com/mattcheah/davinci/blob/master/CODE_OF_CONDUCT.md).