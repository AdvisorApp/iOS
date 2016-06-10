//
//  UvDetailViewControllerTableViewController.swift
//  AdvisorApp
//
//  Created by Damien on 03/06/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit
import Cosmos

class UvDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var userComment: UITextView!
    @IBOutlet weak var uvDescription: UITextView!
    @IBOutlet weak var commentsTitle: UILabel!
    
    var uvComments: [UvUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.refreshControl?.addTarget(self, action: #selector(UvDetailTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)

        navigationItem.title = SharedData.selectedUv?.name
        uvDescription.text = SharedData.selectedUv?._description
        
        // TODO : SHOW AVERAGE AND RATE
        
        refresh()
    }
    
    func refreshList(){
        tableView.estimatedRowHeight = 10
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue Uv detail")
    }
 
    @IBAction func cancelToUvDetailViewController(segue: UIStoryboardSegue) {
        
    }
   
    @IBAction func saveUvComment(segue: UIStoryboardSegue) {
        let selectedCommentContent = SharedData.selectedUvComment
 
        let userId = (SharedData.currentUser?.id)!
        let uvId   = (SharedData.selectedUv?.id)!
        
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
    
    func refresh(sender: AnyObject) {
        refresh()
    }
    
    // Refresh table data
    func refresh() {
        if Auth.isAuthenticated() {
            UvService.getUvUsersFromUvId(
                (SharedData.selectedUv?.id)!,
                failure: { error in
                    print("error : \(error)")
                    Alert.show("An error has occurred", viewController: self)
                }, success: { data in
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
    
    @IBAction func done(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
