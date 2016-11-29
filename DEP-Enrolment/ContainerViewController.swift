//
//  ContainerViewController.swift
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

class ContainerViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Refrence to Main.storyboard & SourceViewController
        let mainStoryboard: NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
        let sourceViewController = mainStoryboard.instantiateController(withIdentifier: "sourceViewController") as! NSViewController
        
        // Set sourceViewController as Child of containerViewContoler, with Index ID of 0 & Display as Subview
        self.insertChildViewController(sourceViewController, at: 0)
        self.view.addSubview(sourceViewController.view)
        self.view.frame = sourceViewController.view.frame
     
        
    }
    

}
