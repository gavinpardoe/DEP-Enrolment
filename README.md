# DEP-Enrolment
DEP Enrolment Setup Screen

### Description

**A Setup/ Splash screen for DEP and user initiated Jamf Pro enrollments. Designed to run post enrollmnet. This is a templete and although it does work as is you are most likley going to need make changes to better suit your requirements and enviromet.**

sreenshot to be added

### Requirements

Created with Xcode 8 and swift 3.0, Xcode 8 or higher needed. Wilst this may be uable with other MDM's it was created for use with Jamf Pro, recomend being on the latest version or at least within the last 3 releases of Jamf Pro.

Tested and Support Clients:

10.11 (El Capitan)
10.12 (Sierra)

In the below documentation there will be refrences to line numbers within Xcode. By default line numbers are not show in Xcode. To show them open Xcode Preferencs and click on the Text Editing tab, within that tab click Editing and then tick the Show Line Numbers check box.

### Editing in Xcode

Download and open the project in Xcode. The navigation pane on the left will list various files:

screenshot to be added

The main files/ folders you will be working with are:

*HTML* - Folder: contains web pages  
*MainWindowController* - Swift Class  
*SourceViewController* - Swift Class  
*SecondViewController* - Swift Class  
*WebViewController* - Swift Class  

##### HTML  

Pretty simple just remove the exiting content in the HTML Folder and drag & drop your own. In the import wizard make sure that Copy Items is checked.  

This is the contect that gets displayed in the WebView. It can also display hosted HTML content such a web pages, instead of using local content.  
