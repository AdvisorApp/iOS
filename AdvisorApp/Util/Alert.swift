//
//  Alert.swift
//  AdvisorApp
//
//  Created by Clément Garbay on 02/06/2016.
//

import UIKit

class Alert {
    
    static func show(title: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func confirm(title: String, message: String, viewController: UIViewController, ok: (Void -> ())) {
        let deleteAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            ok()
        }))
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        viewController.presentViewController(deleteAlert, animated: true, completion: nil)
    }
}