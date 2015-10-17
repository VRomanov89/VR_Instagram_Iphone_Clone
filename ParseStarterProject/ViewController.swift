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

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func pause(sender: AnyObject) {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    @IBAction func restore(sender: AnyObject) {
        activityIndicator.stopAnimating()
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    @available(iOS 8.0, *)
    @IBAction func alert(sender: AnyObject) {
            let alert = UIAlertController(title: "Hey there", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)

            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))

        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        importedImage.image = image
    }
    
    
    @IBAction func importImage(sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }

    @IBOutlet weak var importedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        
        
        
        
        /*
        let product = PFObject(className: "Products")
        product["name"] = "Sandwich"
        product["description"] = "Salami"
        product["price"] = 3.99
        
        product.saveInBackgroundWithBlock{ (success, error) -> Void in
            if success == true {
                print("success")
            }else{
                print("fail")
            }
        } */ /*
        let query = PFQuery(className: "Products")
        query.getObjectInBackgroundWithId("q7qEqM5Pd4", block: {(object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print("error")
            }else if let product = object {
                product["description"] = "Rocky Road"
                product["price"] = 7.48
                product.saveInBackground()
                //print(object!.objectForKey("description"))
                
                
            }
        })
    
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
