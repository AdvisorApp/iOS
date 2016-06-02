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
                navigationItem.title = "Semestre \(semester.number)"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedSemester?.uvs.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->       UITableViewCell {
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
        if segue.identifier == "UvDetailSegue" {
            if let navigationController = segue.destinationViewController as? UINavigationController, cell = sender as? UITableViewCell {
                if let uvDetailViewController = navigationController.topViewController as? UvDetailViewController {
                    let indexPath = uvTableView.indexPathForCell(cell)
                    if let index = indexPath?.row {
                        uvDetailViewController.selectedUv = selectedSemester?.uvs[index]
                    }
                }
            }
        }
    }
    
    @IBAction func cancelToUvViewController(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveUv(segue: UIStoryboardSegue) {
        if let addUvTableViewController = segue.sourceViewController as? AddUvTableViewController {
            // Get new semester and add it to the table view
        }
    }

}
