//
//  AddStudyPlanViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class AddStudyPlanTableViewController: UITableViewController {
    
    var studyPlan: StudyPlan?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveStudyPlanSegue" {
            StudyPlanService.add(Auth.getConnectedUserId()!, name: nameTextField.text!, failure: { error in
                print("Error : \(error)")
            }) { (studyPlan: StudyPlan) in
                dispatch_async(dispatch_get_main_queue()) {
                    self.studyPlan = studyPlan
                    (segue.destinationViewController as? StudyPlanTableViewController)?.addStudyPlan(segue)
                }
            }
        }
    }
}
