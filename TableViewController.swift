//
//  TableViewController.swift
//  InstagramCloneVR
//
//  Created by Volodymyr Romanov on 10/20/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController {
    
    var usernames = [""]
    var userids = [""]
    var isFollowing = [false]

    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFUser.query()
        query?.findObjectsInBackgroundWithBlock({(objects, error) -> Void in
            if let users = objects {
                self.usernames.removeAll(keepCapacity: true)
                self.userids.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                for object in users {
                    if let user = object as? PFUser {
                        if user.objectId! != PFUser.currentUser()?.objectId{
                            self.usernames.append(user.username!)
                            self.userids.append(user.objectId!)
                            let query = PFQuery(className: "followers")
                            query.whereKey("follower", equalTo: (PFUser.currentUser()?.objectId)!)
                            query.whereKey("following", equalTo: user.objectId!)
                            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                                if let objects = objects {
                                    if objects.count > 0 {
                                        self.isFollowing.append(true)
                                    } else {
                                        self.isFollowing.append(false)
                                    }
                                }
                                if self.isFollowing.count == self.usernames.count {
                                    self.tableView.reloadData()
                                }
                            })
                        }
                        
                    }
                }
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel!.text = usernames[indexPath.row]
        if isFollowing[indexPath.row] == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print(indexPath.row)
        let cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        let following = PFObject(className: "followers")
        following["following"] = userids[indexPath.row]
        //print(PFUser.currentUser()?.objectId)
        following["follower"] = PFUser.currentUser()?.objectId
        following.saveInBackground()
    }

}
