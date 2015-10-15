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

class ViewController: UIViewController {

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
        } */
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
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
