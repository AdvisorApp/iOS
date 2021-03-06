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

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Semester \(SharedData.selectedSemester!.number)"
    }
    
    override func viewDidAppear(animated: Bool) {
        refreshViewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (SharedData.selectedSemester?.uvs.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UvCell", forIndexPath: indexPath)
        let uv = (SharedData.selectedSemester?.uvs[indexPath.row])! as Uv
        
        cell.textLabel?.text = "\(uv.remoteId) : \(uv.name)"
        cell.detailTextLabel?.text = uv._description
        if uv.isFinished() {
            cell.accessoryType = .Checkmark
        }
        
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FromUvToUvDetailSegue" {
            if let indexPath = uvTableView.indexPathForSelectedRow {
                SharedData.selectedUv = SharedData.selectedSemester?.uvs[indexPath.row]
            }
        }
    }

    // MARK: - Action methods
    
    @IBAction func toUvViewController(segue: UIStoryboardSegue) {
        
    }
    
    func refreshViewData() {
        dispatch_async(dispatch_get_main_queue(), {
            self.creditHoursLabel.text = SharedData.selectedSemester?.getSumCreditHours().description
            self.uvTableView.reloadData()
        })
    }
}
