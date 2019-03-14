//
//  ViewController.swift
//  SBT-Lesson-5 Swift Practice
//
//  Created by Dmitry Shapkin on 07/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /**
         Here I just repeat the PDF from Lesson-5 SBT.
         Just for fun. Just for practice.
        */
        
        // Constants and variables
        //let maximumNumberOfLoginAttempts = 10
        //var currentLoginAttempt = 0
        
        // var x = 0.0, y = 0.0, z = 0.0
        
        // Type annotations
        //var welcomeMessage: String
        
        // BOOL
        
        //let i: Bool = 1
        
        // if i {
        //  this code will not compile
        // }
        
        typealias MyOwnAlias = UInt8
        
        // Implicitly Unwrapped Optionals
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // requires an exclamation mark
        
        let assumedString: String = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString // no need for an exclamation mark
        
        var test = DSObject()
        print(test.firstClosure)
        //test.secondClosure
        
        
        
    }


}

