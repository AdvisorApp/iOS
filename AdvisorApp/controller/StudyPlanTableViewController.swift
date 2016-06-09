//
//  StudyplanTableViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class StudyPlanTableViewController: UITableViewController {
    
    var studyPlans: [StudyPlan] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(StudyPlanTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // App entry point : Checks if an user is connected
    override func viewDidAppear(animated: Bool) {
        if !Auth.isAuthenticated() {
            self.performSegueWithIdentifier("LoginSegue", sender: self)
        } else {
            refresh()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyPlans.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudyPlanCell", forIndexPath: indexPath)
        let studyPlan = studyPlans[indexPath.row] as StudyPlan
        
        cell.textLabel?.text = studyPlan.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            Alert.confirm("Are you sure you want to delete this study plan ?", message: "All associated data will be deleted.", viewController: self) {
                let studyPlan = self.studyPlans[indexPath.row]
                StudyPlanService.delete(studyPlan.id, failure: { error in
                    Alert.show("An error has occurred when deleting", viewController: self)
                }) {
                    self.studyPlans.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                }
            }
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SemesterSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                SharedData.selectedStudyPlan = studyPlans[indexPath.row]
            }
        }
    }
    
    // MARK: - Action methods
    
    @IBAction func toStudyPlanViewController(segue: UIStoryboardSegue) {
        
    }
    
    func addStudyPlan(segue: UIStoryboardSegue) {
        if let addStudyPlanViewController = segue.sourceViewController as? AddStudyPlanTableViewController {
            if let studyPlan = addStudyPlanViewController.studyPlan {
                studyPlans.append(studyPlan)
                
                let indexPath = NSIndexPath(forRow: studyPlans.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }

    // TODO : Not in adapted file
    @IBAction func signout(sender: UIBarButtonItem) {
        Auth.clear()
        self.performSegueWithIdentifier("LoginSegue", sender: self)
    }
    
    func refresh(sender: AnyObject) {
        refresh()
    }
    
    // Refresh table data
    func refresh() {
        if Auth.isAuthenticated() {
            StudyPlanService.get(Auth.getConnectedUserId()!, failure: { error in
                Alert.show("An error has occurred", viewController: self)
                self.refreshControl?.endRefreshing()
            }) { (studyPlans: [StudyPlan]) in
                studyPlans.first.map({sp in
                    SharedData.currentUser = sp.user
                })
                self.studyPlans = studyPlans
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            }
        }
    }
}
