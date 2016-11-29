//
//  SoruceViewController.swift
//  DEP-Enrolment
//
//  Created by Gavin on 05/11/2016.
//  Copyright © 2016 Trams Ltd. All rights reserved.
//
//  Designed for Use with Jamf Pro.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Gavin Pardoe
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software
//  without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Cocoa


class SoruceViewController: NSViewController, NSTextFieldDelegate {
    
    // Interface Builder Connections
    @IBOutlet weak var userName: NSTextField!
    @IBOutlet weak var assetTag: NSTextField!
    @IBOutlet weak var departmentPopup: NSPopUpButton!
    
    // Create Instance Refrences
    var department: [String]!
    let shellTask = Process()
    
    // Key Refrences for userDetails.plist
    let assetTagKey = "AssetTag"
    let usernameKey = "Username"
    let departmentKey = "Department"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Popup Menu Settings
        department = ["Accounts", "Design", "Marketing", "Operations", "Sales", "Service"] // Modify as required
        departmentPopup.removeAllItems()
        departmentPopup.addItems(withTitles: department)
        departmentPopup.selectItem(at: 0)

        
    }
    
    // Receives Changes to Text Fields from Delegate & Constrains Characters
    override func controlTextDidChange(_ obj: Notification) {
        
        let characterSet: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789-_").inverted
        let alphaCharSet: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ.").inverted
        
        self.assetTag.stringValue = (self.assetTag.stringValue.components(separatedBy: characterSet) as NSArray).componentsJoined(by: "")
        self.userName.stringValue = (self.userName.stringValue.components(separatedBy: alphaCharSet) as NSArray).componentsJoined(by: "")
        
    }

    // Submits the User Data to the Jamf Server and Creates the .plist
    func start() {
        
        // Get NSTextField Values as Strings
        let assetTagValue = self.assetTag.stringValue
        let usernameValue = self.userName.stringValue
        let departmentValue = self.departmentPopup.title
        _ = departmentValue
        
        // Runs the Below Tasks Asynchronously as a Background Process
        DispatchQueue.global(qos: .background).async {
            
            // Run Jamf Recon with User Submited Values
            let appleScriptRecon = NSAppleScript(source: "do shell script \"/usr/local/jamf/bin/jamf recon -assetTag \(assetTagValue) -endUsername \(usernameValue) -department \(departmentValue)\" with administrator " + "privileges")!.executeAndReturnError(nil)
            let result = appleScriptRecon.stringValue
            
            if ((result?.contains("<computer_id")) != nil) {
                //debugPrint("process completed")
                
                // Specify Values for .plist
                if let plist = Plist(name: "userDetails") {
                    
                    let dict = plist.getMutablePlistFile()!
                    dict[self.assetTagKey] = (assetTagValue)
                    dict[self.usernameKey] = (usernameValue)
                    dict[self.departmentKey] = (departmentValue)
                    
                    do {
                        try plist.addValuesToPlistFile(dict)
                    } catch {
                        print(error)
                    }
                    
                    print(plist.getValuesInPlistFile() ?? "missing")
                } else {
                    print("Unable to get Plist")
                }
                
            } else {
                print("process failed")
                
                
                // Specify values for .plist
                if let plist = Plist(name: "userDetails") {
                    
                    let dict = plist.getMutablePlistFile()!
                    dict[self.assetTagKey] = (assetTagValue)
                    dict[self.usernameKey] = (usernameValue)
                    dict[self.departmentKey] = (departmentValue)
                    
                    do {
                        try plist.addValuesToPlistFile(dict)
                    } catch {
                        print(error)
                    }
                    
                    print(plist.getValuesInPlistFile() ?? "missing")
                } else {
                    print("Unable to get Plist")
                }
                
                DispatchQueue.main.async {
                    //print(result!)
                }
            }
        }

        
    }
    
    // Checks for Empty Text Fields, If Empty an Error Message Will be Displayed
    func checkTextfields() {
        
        // Get NSTextField Values as Strings
        let assetTagValue = assetTag.stringValue
        let usernameValue = userName.stringValue
        let departmentValue = departmentPopup.title
        _ = departmentValue
        
        // Make Sure Text Fields are not Empty
        if assetTagValue.isEmpty {
            
            //debugPrint("No Asset Tag Entered")
            missingValuesAlert()
            
        } else if usernameValue.isEmpty {
            
            //debugPrint("No Username Entered")
            missingValuesAlert()
            
        } else {
            
            //debugPrint("Running Command")
            
            // Calls the start Function
            start()
            
            // Performs View Segue, with Custom Segue
            performSegue(withIdentifier: "segue1", sender: self)
            
            }
        
    }

    
    // Display Message if Any Text Fields are Empty
    func missingValuesAlert(){
        
        let alert = NSAlert()
        alert.messageText = "Missing Text Field Values" // Edit as Required
        alert.informativeText = "All Text Fields Must be Populated" // Edit as Required
        alert.addButton(withTitle: "Ok")
        
        alert.beginSheetModal(for: self.view.window!, completionHandler: { (returnCode) -> Void in
            if returnCode == NSAlertFirstButtonReturn {
                
            }
        })
    }

    
    // Refrence to Start Button
    @IBAction func startDEP(_ sender: Any) {
        
        // Calls checkTextfields Function
        checkTextfields()
        
    }
    
 }
