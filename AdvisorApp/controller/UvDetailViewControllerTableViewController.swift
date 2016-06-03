//
//  UvDetailViewControllerTableViewController.swift
//  AdvisorApp
//
//  Created by Damien on 03/06/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class UvDetailViewController: UITableViewController {
    
    var selectedUv: Uv?
    
    var uvComments = [
        UvComment(dictionary: ["content": "test 1"]),
        UvComment(dictionary: ["content": "test 2"]),
        UvComment(dictionary: ["content": "test 3"]),
        UvComment(dictionary: ["content": "test 4"]),
        UvComment(dictionary: ["content": "test 5"]),
        UvComment(dictionary: ["content": "test 6"]),
        UvComment(dictionary: ["content": "test 7"]),
        UvComment(dictionary: ["content": "test 8"]),
        UvComment(dictionary: ["content": "test 9"]),
        UvComment(dictionary: ["content": "test 2"]),
        UvComment(dictionary: ["content": "test 3"]),
        UvComment(dictionary: ["content": "test 4"]),
        UvComment(dictionary: ["content": "test 5"]),
        UvComment(dictionary: ["content": "test 6"]),
        UvComment(dictionary: ["content": "test 7"]),
        UvComment(dictionary: ["content": "test 8"]),
        UvComment(dictionary: ["content": "test 9"]),
        UvComment(dictionary: ["content": "test 2"]),
        UvComment(dictionary: ["content": "test 3"]),
        UvComment(dictionary: ["content": "test 4"]),
        UvComment(dictionary: ["content": "test 5"]),
        UvComment(dictionary: ["content": "test 6"]),
        UvComment(dictionary: ["content": "test 7"]),
        UvComment(dictionary: ["content": "test 8"]),
        UvComment(dictionary: ["content": "test 9"]),
        UvComment(dictionary: ["content": "test 10"])
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 5
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return uvComments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UvDetailCell", forIndexPath: indexPath)
        
        let uv = (uvComments[indexPath.row]) as UvComment
        
        
        cell.textLabel?.text = uv.content

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
