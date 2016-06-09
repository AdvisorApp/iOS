//
//  AddUvCommentController.swift
//  AdvisorApp
//
//  Created by Damien on 03/06/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class AddUvCommentController: UITableViewController {
    
    @IBOutlet weak var commentTextView: UITextView!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        SharedData.selectedUvComment = commentTextView.text
    }
    
    
    

}
