//
//  SemesterViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class SemesterTableViewController: UITableViewController {
    
    var selectedStudyPlan: StudyPlan?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(SemesterTableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)

        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedStudyPlan?.semesters.count)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SemesterCell", forIndexPath: indexPath)
        let semester = (selectedStudyPlan?.semesters[indexPath.row])! as Semester
        
        cell.textLabel?.text = "Semester \(semester.number)"

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            Alert.confirm("Are you sure you want to delete this semester ?", message: "All associated data will be deleted.", viewController: self) {
                let semester = self.selectedStudyPlan?.semesters[indexPath.row]
                SemesterService.delete(semester!.id, failure: { error in
                    Alert.show("An error has occurred when deleting", viewController: self)
                    print(error)
                }) {
                    self.selectedStudyPlan?.semesters.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UvSegue" {
            if let uvViewController = segue.destinationViewController as? UvViewController, cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                if let index = indexPath?.row {
                    uvViewController.selectedSemester = (selectedStudyPlan?.semesters[index])!
                }
            }
        }
    }
    
    @IBAction func cancelToSemesterViewController(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func addSemester(sender: UIBarButtonItem) {
        SemesterService.add(selectedStudyPlan!.id, failure: { error in
            Alert.show("An error has occurred", viewController: self)
        }) { (semester: Semester) in
            self.selectedStudyPlan?.semesters.append(semester)
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
    }
    
    func refresh(sender: AnyObject) {
        refresh()
    }
    
    // Refresh table data
    func refresh() {
        if Auth.isAuthenticated() {
            SemesterService.get(selectedStudyPlan!.id, failure: { error in
                Alert.show("An error has occurred", viewController: self)
                self.refreshControl?.endRefreshing()
            }) { (semesters: [Semester]) in
                self.selectedStudyPlan?.semesters = semesters
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            }
        }
    }
}
