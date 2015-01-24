//
//  ViewController.swift
//  TinderClone
//
//  Created by Akkshay Khoslaa on 1/9/15.
//  Copyright (c) 2015 Akkshay Khoslaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var fbloginView:FBLoginView = FBLoginView(readPermissions: ["email", "public_profile"])

    @IBOutlet weak var loginCancelledLabel: UILabel!
    
    @IBAction func signIn(sender: AnyObject) {
        var permissions = ["email,", "public_profile"]
        self.loginCancelledLabel.alpha = 0
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
                self.loginCancelledLabel.alpha = 1
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                self.performSegueWithIdentifier("signupSegue", sender: self)
            } else {
                NSLog("User logged in through Facebook!")
                
            }
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if PFUser.currentUser() != nil {
            println("User logged in")
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

