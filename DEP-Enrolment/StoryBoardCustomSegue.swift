//
//  StoryBoardCustomSegue.swift
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

// Creates a Custom Storyboard Segue between Source & Second View Controllers
class StoryBoardCustomSegue: NSStoryboardSegue {
    
    override init(identifier: String?,
                  source sourceController: Any,
                  destination destinationController: Any) {
        var myIdentifier : String
        if identifier == nil {
            myIdentifier = ""
        } else {
            myIdentifier = identifier!
        }
        
        super.init(identifier: myIdentifier, source: sourceController, destination: destinationController)
        
        }
    
    override func perform() {
        
        let sourceViewController = self.sourceController as! NSViewController
        let destinationViewController = self.destinationController as! NSViewController
        let containerViewController = sourceViewController.parent! as NSViewController
        
        containerViewController.insertChildViewController(destinationViewController, at: 1)

        sourceViewController.view.wantsLayer = true
        destinationViewController.view.wantsLayer = true
        
        containerViewController.transition(from: sourceViewController, to: destinationViewController, options: NSViewControllerTransitionOptions.crossfade, completionHandler: nil)
        
    }

}
