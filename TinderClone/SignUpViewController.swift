//
//  SignUpViewController.swift
//  TinderClone
//
//  Created by Akkshay Khoslaa on 1/11/15.
//  Copyright (c) 2015 Akkshay Khoslaa. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    
    @IBOutlet var genderSwitch: UISwitch!
    
    @IBAction func signUp(sender: AnyObject) {
        
        var user = PFUser.currentUser()
        
        if genderSwitch.on {
            
            user["interestedIn"]="female"
            
        } else {
            
            user["interestedIn"]="male"
            
        }
        
        user.saveInBackgroundWithTarget(nil, selector: nil)
        self.performSegueWithIdentifier("signedUp", sender: self)
        
    }
    
    @IBOutlet var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var user = PFUser.currentUser()
        
        var FBSession = PFFacebookUtils.session()
        
        var accessToken = FBSession.accessTokenData.accessToken
        
        let url = NSURL(string: "https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token="+accessToken)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            let image = UIImage(data: data)
            
            self.profilePic.image = image
            
            user["image"] = data
            
            user.saveInBackgroundWithTarget(nil, selector: nil)
            
            FBRequestConnection.startForMeWithCompletionHandler({
                connection, result, error in
                
                user["gender"] = result["gender"]
                user["name"] = result["name"]
                user["email"] = result["email"]
                
                user.saveInBackgroundWithTarget(nil, selector: nil)
                
                println(result)
                
                
            })
            
        })
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

