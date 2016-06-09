//
//  AddUvTableViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 27/05/2016.
//

import UIKit

class AddUvTableViewController: UITableViewController {
    
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
        
        cell.nameLabel?.text = "\(uv.remoteId) : \(uv.name)"
        
        let prerequisitesUv = uv.prerequisitesUv.map {uv in uv.name}
        cell.prerequisitesLabel.text = (prerequisitesUv.count == 0) ? "None" : prerequisitesUv.joinWithSeparator(",")
        
        let corequisitesUv = uv.corequisitesUv.map {uv in uv.name}
        cell.corequisitesLabel.text = (corequisitesUv.count == 0) ? "None" : corequisitesUv.joinWithSeparator(",")
        
        cell.infoButton.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let uv = remainingUvs[indexPath.row] as Uv
        
        SemesterService.addUv((SharedData.selectedSemester?.id)!, uvId: uv.id, failure: { error in
            Alert.show("An error has occurred", viewController: self)
        }, success: { _ in
            SharedData.selectedSemester?.uvs.append(uv)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FromAddUvToUvDetailSegue" {
            let button = sender as! UIButton
            SharedData.selectedUv = remainingUvs[button.tag]
        }
    }
    
    // Refresh table data
    func refresh() {
        if Auth.isAuthenticated() {
            UvService.get((SharedData.selectedSemester?.studyPlan?.id)!, failure: { error in
                print(error)
                Alert.show("An error has occurred", viewController: self)
            }) { (uvs: [Uv]) in
                if uvs.count == 0 {
                    Alert.show("No UV available", viewController: self)
                } else {
                    self.remainingUvs = uvs
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
            }
        }
    }

}
