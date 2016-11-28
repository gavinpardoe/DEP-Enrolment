# DEP-Enrolment
DEP Enrolment Setup Screen

### Description

**A Setup/ Splash screen for DEP and user initiated Jamf Pro enrollments. Designed to run post enrollmnet. This is a templete and although it does work as is you are most likley going to need make changes to better suit your requirements and enviromet.**

![alt tag](https://github.com/gavinpardoe/DEP-Enrolment/blob/master/Screenshots/View%201.png?raw=true)

### Requirements

Created with Xcode 8 and swift 3.0, Xcode 8 or higher needed. Wilst this may be uable with other MDM's it was created for use with Jamf Pro, recomend being on the latest version or at least within the last 3 releases of Jamf Pro.

Tested and Supported Clients:

10.11 (El Capitan)  
10.12 (Sierra)

In the below documentation there will be refrences to line numbers within Xcode. By default line numbers are not show in Xcode. To show them open Xcode Preferencs and click on the Text Editing tab, within that tab click Editing and then tick the Show Line Numbers check box.

### App Structure  

![alt tag](https://github.com/gavinpardoe/DEP-Enrolment/blob/master/Screenshots/structure.png?raw=true)  

### Editing in Xcode

**Im only going to list some of the basic changes that can be made, to list everything would take a lot of documentation!**  

Download and open the project in Xcode. The navigation pane on the left will list various files:

![alt tag](https://github.com/gavinpardoe/DEP-Enrolment/blob/master/Screenshots/xcodeStructure.png?raw=true)  

The main files/ folders you will be working with are:

*HTML* - Folder: contains web pages  
*MainWindowController* - Swift Class  
*SourceViewController* - Swift Class  
*SecondViewController* - Swift Class  
*WebViewController* - Swift Class   
*info.plist* - plist  

#### HTML  

Pretty simple just remove the exiting content in the HTML Folder and drag & drop your own. In the import wizard make sure that Copy Items is checked.  

This is the contect that gets displayed in the WebView. It can also display hosted HTML content such a web pages, instead of using local content.  

#### MainViewController  

Subclass of NSWindowContoller. Used by MainWindow in the storyboard to set window size, level and apperance.  

To Change Window Size: (Note this have been designed to run using the full size of the main screen)  
Edit ```let percent: CGFloat = 1.0``` on line 40 of MainViewController.swift, where 1.0 = 100%, 0.5 = 50%  

To Change background colour:  
Edit ```window?.backgroundColor = NSColor.white``` on line 35 of MainViewController.swift, where white = colour (Black, Blue, Red, etc)  

#### SourceViewController  

Subclass of NSViewController & NSTextFieldDelegate. Used by the SourceView.  

Add/ remove departments:  

Edit ```department = ["Accounts", "Design", "Marketing", "Operations", "Sales", "Service"]``` on line 48 of SourceViewController.swift, change remove the department names within the quotes. You can add more entries just make sure to comma seperate them.  
**Note that the departments must exist within departments in your Jamf server**  

Modify Text Field constraints:  
These restrict the characters that can be typed in the text fields.  

Edit ```let characterSet: CharacterSet = CharacterSet(charactersIn:     "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789-_").inverted``` and ```let alphaCharSet: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ.").inverted```  on lines 59 & 60  
Characters listed are allowed, anything not listed is restricted. CharaterSet applies to the Asset Tag Field and alphaCharSet applies to the Username field.  

Empty Text Fields:  
If either text field is empty the app will not continue and an error message will be displayed, this will change the message in the error.  

Edit ```alert.messageText = "Missing Text Field Values"``` and/or ```alert.informativeText = "All Text Fields Must be Populated"```  
Change the text within the quotes.  

#### SecondViewController  

subclass of NSViewController. Used by the SecondView  

Custom Policy Trigger:  

Edit ```let appleScriptPolicy = NSAppleScript(source: "do shell script \"/usr/local/jamf/bin/jamf policy -event DEP \" with administrator " + "privileges")!.executeAndReturnError(nil)``` on line 86 change DEP after 'jamf policy -event' with your custom policy trigger name.  

Check Policy Receipt Time:  
How often policy receipts are checked, default is 8 seconds.  

Edit ```let timerInt = TimeInterval(8.0)``` on line 212 change 8.0 to amount os seconds reqiured.  

#### WebViewController  

subclass of NSViewController. Used by the WebView  


#### Stop cmd + q from quting the App   

We can use info.plist to make the application run as an agent. This stops is displaying in the dock or have a menu bar, which it very hard to close the app until its finished.  

View info.plist and look for the 'Application is agent (UIElement)' property, change the value from NO to YES (is handy to have this set to NO while testing and debuging).  


### Usage with Jamf Pro  



