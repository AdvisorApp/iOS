//
//  GlobalStudyPlanTableViewController.swift
//  AdvisorApp
//
//  Created by Ananas-Mac on 06/06/16.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class GlobalStudyPlanTableViewController: UITableViewController {

    let currentSemesters = SharedData.selectedStudyPlan!.semesters;
    
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Global View \(SharedData.selectedStudyPlan!.name)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Know the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (currentSemesters.count);
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Semester \(currentSemesters[section].number)"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (currentSemesters[section].uvs.count);
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UvCell", forIndexPath: indexPath)
        let uv   = (currentSemesters[indexPath.section].uvs[indexPath.row]) as Uv
        cell.textLabel?.text = "\(uv.remoteId) : \(uv.name)"
        return cell
    }
}
