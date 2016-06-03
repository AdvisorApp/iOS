//
//  UvViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class UvViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var creditHoursLabel: UILabel!
    @IBOutlet weak var uvTableView: UITableView!
    
    var selectedSemester: Semester? {
        didSet {
            if let semester = selectedSemester {
                navigationItem.title = "Semester \(semester.number)"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshCreditHoursLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedSemester?.uvs.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UvCell", forIndexPath: indexPath)
        let uv = (selectedSemester?.uvs[indexPath.row])! as Uv
        
        cell.textLabel?.text = uv.name
        cell.detailTextLabel?.text = uv._description
        if uv.isFinished() {
            cell.accessoryType = .Checkmark
        }
        
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FromUvToUvDetailSegue" {
            if let navigationController = segue.destinationViewController as? UINavigationController, cell = sender as? UITableViewCell {
                if let uvDetailViewController = navigationController.topViewController as? UvDetailViewController {
                    let indexPath = uvTableView.indexPathForCell(cell)
                    if let index = indexPath?.row {
                        uvDetailViewController.selectedUv = selectedSemester?.uvs[index]
                    }
                }
            }
        }  else if segue.identifier == "AddUvSegue" {
            if let navigationController = segue.destinationViewController as? UINavigationController {
                if let addUvViewController = navigationController.topViewController as? AddUvTableViewController {
                    addUvViewController.selectedSemester = selectedSemester
                }
            }
        }
    }
    
    @IBAction func cancelToUvViewController(segue: UIStoryboardSegue) {
        
    }

    func refreshCreditHoursLabel() {
        creditHoursLabel.text = selectedSemester?.getSumCreditHours().description
    }
}
