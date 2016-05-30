//
//  StudyplanTableViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class StudyPlanTableViewController: UITableViewController {
    
    var studyPlans: [StudyPlan] = [
        StudyPlan(id: 1, name: "StudyPlan1", semesters: [
            Semester(id: 1, number: 1, uvs: [
                Uv(name: "UV1", description: "Le premier UV", chs: 2),
                Uv(name: "UV2", description: "Le second UV", chs: 4)
            ]),
            Semester(id: 2, number: 2, uvs: [])
        ]),
        StudyPlan(id: 2, name: "StudyPlan2", semesters: [])
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
        cell.detailTextLabel?.text = String(studyPlan.id)
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SemesterSegue" {
            if let semesterViewController = segue.destinationViewController as? SemesterTableViewController, cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                if let index = indexPath?.row {
                    semesterViewController.selectedStudyPlan = studyPlans[index]
                }
            }
        }
    }
    
    @IBAction func cancelToStudyPlanViewController(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveStudyPlan(segue: UIStoryboardSegue) {
        if let addStudyPlanViewController = segue.sourceViewController as? AddStudyPlanTableViewController {
            if let studyPlan = addStudyPlanViewController.studyPlan {
                studyPlans.append(studyPlan)
                
                let indexPath = NSIndexPath(forRow: studyPlans.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }

}
