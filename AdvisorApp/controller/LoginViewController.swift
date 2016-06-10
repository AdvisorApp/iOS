//
//  LoginViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 27/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var alfred: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signin(sender: UIButton) {
        UserService.signin(emailTextField.text!, password: passwordTextField.text!, failure: { error in
            switch error {
            case .Unauthorized:
                Alert.show("Email or password incorrect", viewController: self)
            default:
                Alert.show("An error has occurred", viewController: self)
            }
        }) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelToLoginViewController(segue: UIStoryboardSegue) {
        
    }
}
