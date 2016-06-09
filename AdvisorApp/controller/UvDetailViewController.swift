//
//  UvDetailViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 27/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class UvDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = SharedData.selectedUv!.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func done(sender: UIBarButtonItem) {
        SharedData.selectedUv = nil
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
