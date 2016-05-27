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
    
    var selectedUv: Uv? {
        didSet {
            if let uv = selectedUv {
                print(uv)
                navigationItem.title = uv.name
                //descriptionTextView.text = uv.description
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
