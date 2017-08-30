# Davinci Reference

## How does davinci work?

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

## Theme files from Sublime

### Finding Sublime Theme Files

__WINDOWS__

* If you've downloaded a non-default theme and are using it in Sublime, it is most likely in your Packages/User/ folder. In the Sublime menu, select Preferences > Browse Packages, which will open an explorer/finder window in your Sublime's packages folder. Navigate to /User/ or find the folder in which you selected your theme originally (Preferences > Color Scheme > [Folder])

* If you'd like to translate a default color scheme, it is recommended that you download (PackageResourceViewer)[https://github.com/skuroda/PackageResourceViewer] and install it in Sublime to easily view your default color scheme files. After installing, open the command palette (Ctrl+Shift+P) and search for "Open Resource". Click that and then choose "Color Scheme - Default". Then choose the color scheme you want to translate.

### Installing Translated Sublime Theme Files

__WINDOWS__

* The best way to install a new sublime theme is to go to /packages/user/ and create a folder called "Color Scheme", then place your new .tmTheme file inside that folder. 

* Next, open up your user settings by going to Preferences > Settings - User, and set the filepath in the options: `"color_scheme": "Packages/User/Color Scheme/[YOUR THEME].tmTheme",`

* This should add your Color Scheme folder to the Color Scheme option under Preferences, and allow you to choose this theme whenever you want. 

## Theme files from Atom

### Finding Atom Theme Files

__WINDOWS__

* If you're using a custom theme that you've installed already, it is most likely in `/Users/[USER]/.atom/packages`. If it is not, your best bet would be to go to the Atom settings>Theme, and click the 'settings' cog icon next to your chosen syntax-theme. Next to the "View on Atom.io" and "LICENSE" buttons, there should be a "View Code" button. This will open your theme folder as a new project, where you can right click the folder and choose "show in explorer"

* If you're using a default theme, the easiest way to get these files is to clone it from github. The theme repository can be found when you select the default theme in Settings > Themes, and then click the 'settings' cog icon to reveal a link to github.

### Installing Translated Atom Theme Files

__WINDOWS__

* Move your new theme folder into `/Users/[USER]/.atom/packages` and refresh Atom if you're not in dev mode (Ctrl+Shift+f5). Your theme should be available in the Settings > Themes > Syntax Themes dropdown. 

* If this doesn't work, or you want your theme directory in another location, open a terminal in the location where your theme folder is and type `apm link [YOUR THEME FOLDER]`. A link should be created from the .atom/packages folder to your theme folder. Then refresh Atom.  