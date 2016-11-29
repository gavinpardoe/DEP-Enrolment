//
//  SecondViewController.swift
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

class SecondViewController: NSViewController {

    // Interface Builder Connections
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var prog1: NSProgressIndicator!
    @IBOutlet weak var prog2: NSProgressIndicator!
    @IBOutlet weak var prog3: NSProgressIndicator!
    @IBOutlet weak var prog4: NSProgressIndicator!
    @IBOutlet weak var tick1: NSImageView!
    @IBOutlet weak var tick2: NSImageView!
    @IBOutlet weak var tick3: NSImageView!
    @IBOutlet weak var tick4: NSImageView!
    @IBOutlet weak var finishButton: NSButton!
    @IBOutlet weak var mainLabel: NSTextField!
    
    
    // Create Instance Refrences
    var timer = Timer()
    let receiptPath = FileManager.default
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides Spinning Progress Indicators when not Animated
        prog1.isDisplayedWhenStopped = false
        prog2.isDisplayedWhenStopped = false
        prog3.isDisplayedWhenStopped = false
        prog4.isDisplayedWhenStopped = false
        
        // Starts Progress Indicators
        prog1.startAnimation(self)
        prog2.startAnimation(self)
        prog3.startAnimation(self)
        prog4.startAnimation(self)
        
        // Hides & Disables the Finish Button
        finishButton.isHidden = true
        finishButton.isEnabled = false
        
        // Calls jamfPolicy Function
        jamfPolicy()
        
        // Starts statusLable Timer Function
        statusLabelTimer()
        
        // Starts Install Progress Check
        installProgress()
        
    }
    
    // Call Custom Policy
    func jamfPolicy() {
        
        // Runs the Below Task Asynchronously as a Background Process
        DispatchQueue.global(qos: .background).async {
        
        // Calls jamf policy with Custom Trigger
        let appleScriptPolicy = NSAppleScript(source: "do shell script \"/usr/local/jamf/bin/jamf policy -event DEP \" with administrator " + "privileges")!.executeAndReturnError(nil)
        _ = appleScriptPolicy.stringValue
            
        DispatchQueue.main.async {
            
        //print(policyResult!)
            
            }
        }
        
    }
    
    // Calls statusLabel Function every 2 Seconds
    func statusLabelTimer() {
        
        let timerInt = TimeInterval(2.0)
        timer = Timer.scheduledTimer(timeInterval: timerInt, target: self, selector: #selector(updateStatusLabel), userInfo: nil, repeats: true)
        timer.fire()
        
    }
    
    // Updates the statusLabel
    func updateStatusLabel() {
        
        statusLabel.stringValue = showLog()
        
    }

    // Reads the Last Line from the Jamf Log & Trim's off Time Stamps & White Space
    // The below function is from Jason Tratta's Progress Screen (https://github.com/jason-tratta/ProgressScreen/blob/master/ProgressScreen/AppDelegate.swift)
    func showLog() ->String {
        
        if let log = NSData(contentsOfFile: "/private/var/log/jamf.log") {
            
            let logString =  NSString(data: log as Data, encoding: String.Encoding.utf8.rawValue)
            
            let theRange = logString?.range(of: "]:", options: .backwards)
            let scanner = Scanner(string: logString as! String)
            scanner.scanLocation = (theRange?.location)!
            
            let lineReturn = NSMutableCharacterSet.newline()
            
            var logLine: NSString?
            while scanner.scanUpToCharacters(from: lineReturn as CharacterSet, into: &logLine),
                let _ = logLine
                
            {
                //debugPrint("Log Line: \(logLine)")
                
            }
            
            let trimTimeStamp = logLine!.replacingOccurrences(of: "]:", with: "")
            let removedSlash =  trimTimeStamp.replacingOccurrences(of: "\"", with: "") as NSString!
            let trimedWhiteSpace = removedSlash?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
            return trimedWhiteSpace!
            
        } else {
            
            return "JAMF Log Not Found." }
        
    }

    
    // Checks for Installation Recipts
    func checkInstallProgress() {
        
        if receiptPath.fileExists(atPath: "/Library/Application Support/JAMF/Applications.receipt") {
            
            self.prog1.stopAnimation(self)
            self.tick1.image = NSImage(named: "check.png")
            
        } else {
            
            //debugPrint("Applications Not Installed")
        }
        
        if receiptPath.fileExists(atPath: "/Library/Application Support/JAMF/UISettings.receipt") {
            
            self.prog2.stopAnimation(self)
            self.tick2.image = NSImage(named: "check.png")
            
        } else {
            
            //debugPrint("UI Settings Not Applied")
        }
        
        if receiptPath.fileExists(atPath: "/Library/Application Support/JAMF/SystemSettings.receipt") {
            
            self.prog3.stopAnimation(self)
            self.tick3.image = NSImage(named: "check.png")
            
        } else {
            
            //debugPrint("System Settings Not Applied")
        }
        
        if receiptPath.fileExists(atPath: "/Library/Application Support/JAMF/SecuritySettings.receipt") {
            
            self.prog4.stopAnimation(self)
            self.tick4.image = NSImage(named: "check.png")
            
        } else {
            
            //debugPrint("Security Settings Not Applied")
        }
        
        if receiptPath.fileExists(atPath: "/Library/Application Support/JAMF/DEPSetupComplete.receipt") {
            
            // Updates the Main Image and Label on Completion
            self.imageView.image = NSImage(named: "mbpWhiteTick.png")
            mainLabel.stringValue = "Setup Complete"
            
            // Enables and Displays the Finish Button on Completion
            finishButton.isHidden = false
            finishButton.isEnabled = true
            
        } else {
            
        }
        
    }

    // Calls ""checkInstallProgess" Function Every 8 Seconds
    func installProgress() {
        
        let timerInt = TimeInterval(8.0)
        timer = Timer.scheduledTimer(timeInterval: timerInt, target: self, selector: #selector(checkInstallProgress), userInfo: nil, repeats: true)
        timer.fire()
        
    }

    // Interface Builder Connection to Finish Button
    @IBAction func finish(_ sender: Any) {
        
        do {
            
            // Cleans up the Receipts
            try fileManager.removeItem(atPath: "/Library/Application Support/JAMF/Applications.receipt")
            try fileManager.removeItem(atPath: "/Library/Application Support/JAMF/UISettings.receipt")
            try fileManager.removeItem(atPath: "/Library/Application Support/JAMF/SystemSettings.receipt")
            try fileManager.removeItem(atPath: "/Library/Application Support/JAMF/SecuritySettings.receipt")
            try fileManager.removeItem(atPath: "/Library/Application Support/JAMF/DEPSetupComplete.receipt")
            
        }
            
        catch let error as Error {
            print("Recipt Not Removed: \(error)")
        }
        
        // Performs View Segue to the Web View
        performSegue(withIdentifier: "segue2", sender: self)
        
        // Closes the Current Window
        self.view.window?.close()
        
    }

    
}
