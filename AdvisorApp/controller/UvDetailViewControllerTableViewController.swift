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
    
    @IBOutlet weak var userComment: UITextView!
    
    @IBOutlet weak var uvDescription: UITextView!
    
    var uvComments: [UvUser] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    
        //self.refreshControl?.addTarget(self, action: #selector(UvDetailViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        refresh()
        
        
        
        uvDescription.text = selectedUv?._description
        
        //self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0) // Status bar inset

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refreshList(){
        tableView.estimatedRowHeight = 10
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
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
        return uvComments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath) as! BasicCell
        
        let uv = (uvComments[indexPath.row]) as UvUser
        
        cell.label?.text = uv.uvComment

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue Uv detail")
    }
 
    
    
    @IBAction func cancelToUvDetailViewController(segue: UIStoryboardSegue) {
        
    }
    
    
    @IBAction func saveUvComment(segue: UIStoryboardSegue) {
        print("HELLEOOELAZDAMZLJDM")
        print(SharedData.selectedUvComment)
        //let comment = "azdazd"
        
        let selectedCommentContent = SharedData.selectedUvComment
 
        let userId = (SharedData.currentUser?.id)!
        let uvId   = (selectedUv?.id)!
        
        UvService.addCommentOrMark(
            userId,
            uvId: uvId,
            comment: selectedCommentContent,
            mark: nil,
            failure: { error in
                print("error : \(error)")
                Alert.show("An error has occurred", viewController: self)
            }, success: { data in
                // TODO : adding new UV to UV list (UvView)
                // SharedData.selectedSemester?.uvs.append(uv)
                //self.dismissViewControllerAnimated(true, completion: nil)
                print("success \(data)")
                SharedData.selectedUvComment = nil
                self.refresh()
                self.refreshList()
        })
    }
    
    
    // Refresh table data
    func refresh() {
        if Auth.isAuthenticated() {
            UvService.getUvUsersFromUvId(
                (selectedUv?.id)!,
                failure: { error in
                    print("error : \(error)")
                    Alert.show("An error has occurred", viewController: self)
                }, success: { data in
                    print(data)
                    self.uvComments = data
                    self.refreshList()
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                    })

                }
            )

        }
    }
    

}
