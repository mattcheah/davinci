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

Enter 1 or 2 to select your text editor. The system will then ask for the theme file or theme folder. 
To figure out where this is, see the #Reference section.
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
To add this newly created theme to your text editor, read the #Reference section. 

To exit the program any time, press ctrl+c

## Warnings

Theme files are parsed by an XML Parser or by Regex. Both of these parsing methods can be potentially unreliable depending on the scopes assigned to the colors in the Sublime XML file, or the combination of Less selectors in the Atom combined file. 

This is further complicated by the fact that editors do not always categorize the same code in the same way. As an example, the `System` in the following Java code

    System.out.println("Hello World!");

is categorized in Sublime as a "Storage Type" keyword, usually reserved for keywords that affect the storage of an item (eg. __void__ in Java). However, in Atom, `System` is given the classes `"syntax--variable syntax--other syntax--object syntax--java"`. The most common of these classes would be `syntax--variable`, meaning that even if colors from other classes are parsed (they're not), the color would not necessarily show up the same when transferring between Atom and Sublime.  

All this to say that the process is unstable and you may have to do a little bit of clean-up work on your resulting theme-files. I have found, however, that the overall look and feel of the theme is preserved.

## Reference

### How does davinci work?

Sublime Text themes are parsed using [Nokogiri](https://github.com/sparklemotion/nokogiri), an HTML/XML parser. 
Atom theme files (.less) are combined into one file using [Coyote](https://github.com/xorcery/coyote) and then parsed using regex.

Once these files are parsed, the colors for categories of code are slotted into an options hash which looks similar to this: 

    @options{
        :foreground => "#000000" // Primary Text Color is Black
        :background => "#FFFFFF" // Primary Background Color is White
        :comment_foreground => "#555555" // Comment color is grey
        :number_foreground => "#FF0000" // Number/Integer color is red
        :string_foreground => "#00FF00" // String color is green
    }
    
Once the input theme has been parsed and the options hash is full, davinci will clone a template for your output theme and find/replace strings representing options with the actual colors, like so: 

    <key>name</key>
	<string>String</string>
	<key>foreground</key>
	<string>":::string_foreground:::"</string>
	
    @template.gsub!(/":::string_foreground:::"/, "#00FF00")

To see a list of options and where each color is set in each theme's file(s), view the [reference spreadsheet](https://docs.google.com/spreadsheets/d/1DqhOP7L2ApQSOU6tKnh1Bx-92pzY7-BJK2Yccf6wr-c/edit?usp=sharing). 

### Theme files from Sublime

#### Finding Sublime Theme Files

__WINDOWS__

* If you've downloaded a non-default theme and are using it in Sublime, it is most likely in your Packages/User/ folder. In the Sublime menu, select Preferences > Browse Packages, which will open an explorer/finder window in your Sublime's packages folder. Navigate to /User/ or find the folder in which you selected your theme originally (Preferences > Color Scheme > [Folder])

* If you'd like to translate a default color scheme, it is recommended that you download (PackageResourceViewer)[https://github.com/skuroda/PackageResourceViewer] and install it in Sublime to easily view your default color scheme files. After installing, open the command palette (Ctrl+Shift+P) and search for "Open Resource". Click that and then choose "Color Scheme - Default". Then choose the color scheme you want to translate.

#### Installing Translated Sublime Theme Files

__WINDOWS__

* The best way to install a new sublime theme is to go to /packages/user/ and create a folder called "Color Scheme", then place your new .tmTheme file inside that folder. 

* Next, open up your user settings by going to Preferences > Settings - User, and set the filepath in the options: `"color_scheme": "Packages/User/Color Scheme/[YOUR THEME].tmTheme",`

* This should add your Color Scheme folder to the Color Scheme option under Preferences, and allow you to choose this theme whenever you want. 

### Theme files from Atom

#### Finding Atom Theme Files

__WINDOWS__

* If you're using a custom theme that you've installed already, it is most likely in `/Users/[USER]/.atom/packages`. If it is not, your best bet would be to go to the Atom settings>Theme, and click the 'settings' cog icon next to your chosen syntax-theme. Next to the "View on Atom.io" and "LICENSE" buttons, there should be a "View Code" button. This will open your theme folder as a new project, where you can right click the folder and choose "show in explorer"

* If you're using a default theme, the easiest way to get these files is to clone it from github. The theme repository can be found when you select the default theme in Settings > Themes, and then click the 'settings' cog icon to reveal a link to github.

#### Installing Translated Atom Theme Files

__WINDOWS__

* Move your new theme folder into `/Users/[USER]/.atom/packages` and refresh Atom if you're not in dev mode (Ctrl+Shift+f5). Your theme should be available in the Settings > Themes > Syntax Themes dropdown. 

* If this doesn't work, or you want your theme directory in another location, open a terminal in the location where your theme folder is and type `apm link [YOUR THEME FOLDER]`. A link should be created from the .atom/packages folder to your theme folder. Then refresh Atom.  

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattcheah/davinci. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### Support for new editors

Contributors who would like to add support for a new editor should make sure their pull request contains the following: 
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