/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController{
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var signupActive = true
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registeredText: UILabel!
    @available(iOS 8.0, *)
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {(action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @available(iOS 8.0, *) // Required to use for old iOS
    @IBAction func signUp(sender: AnyObject) {
        if username.text == "" || password.text == "" {
            displayAlert("Error in form", message: "Please enter a username and password")
        } else {
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var errorMessage = "Please try again later" // Placeholder error message
            if signupActive == true {
            // Create a new user
                let user = PFUser()
                user.username = username.text
                user.password = password.text
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    if error == nil {
                        //Signup successful
                    } else {
                        if let errorString = error!.userInfo["error"] as? NSString {
                            errorMessage = errorString as String
                        }
                        self.displayAlert("Failed Signup", message: errorMessage)
                    }
                })
            } else {
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: {(user, error) -> Void in
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    if user != nil {
                        
                    }else{
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        self.displayAlert("Failed Login", message: errorMessage)
                    }
                })
            }
        }
    }
       @IBAction func Login(sender: AnyObject) {
        if (signupActive == true) {
            mainButton.setTitle("Login", forState: UIControlState.Normal)
            registeredText.text = "Not registered?"
            secondaryButton.setTitle("Sign Up", forState: UIControlState.Normal)
            signupActive = false
        } else {
            mainButton.setTitle("Sign Up", forState: UIControlState.Normal)
            registeredText.text = "Already registered?"
            secondaryButton.setTitle("Login", forState: UIControlState.Normal)
            signupActive = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
