//
//  AddUvTableViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 27/05/2016.
//

import UIKit

class AddUvTableViewController: UITableViewController {
    
    var selectedSemester: Semester?
    var remainingUvs: [Uv] = []

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return remainingUvs.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AddUvCell", forIndexPath: indexPath) as! UvCell
        let uv = remainingUvs[indexPath.row] as Uv
        
        cell.nameLabel?.text = uv.name
        
        let prerequisitesUv = uv.prerequisitesUv.map {uv in uv.name}
        cell.prerequisitesLabel.text = (prerequisitesUv.count == 0) ? "None" : prerequisitesUv.joinWithSeparator(",")
        
        let corequisitesUv = uv.corequisitesUv.map {uv in uv.name}
        cell.corequisitesLabel.text = (corequisitesUv.count == 0) ? "None" : corequisitesUv.joinWithSeparator(",")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let uv = remainingUvs[indexPath.row] as Uv
        
        SemesterService.addUv((selectedSemester?.id)!, uvId: uv.id, failure: { error in
            Alert.show("An error has occurred", viewController: self)
        }, success: { _ in
            // TODO : adding new UV to UV list (UvView)
            // SharedData.selectedSemester?.uvs.append(uv)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FromAddUvToUvDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                SharedData.selectedUv = remainingUvs[indexPath.row]
            }
        }
    }
    
    // Refresh table data
    func refresh() {
        if Auth.isAuthenticated() {
            UvService.get((SharedData.selectedSemester?.studyPlan?.id)!, failure: { error in
                Alert.show("An error has occurred", viewController: self)
            }) { (uvs: [Uv]) in
                self.remainingUvs = uvs
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
    }

}
