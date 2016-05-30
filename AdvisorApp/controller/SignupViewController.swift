//
//  SignupViewController.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 27/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var remoteIdTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(sender: UIButton) {
        let user = UserSignUp(
            email: emailTextField.text!,
            password: passwordTextField.text!,
            firstName: firstNameTextField.text!,
            lastName: lastNameTextField.text!,
            remoteId: remoteIdTextField.text!
        )
        
        if(user.isEnoughComplete()){
            UserService.signup(user, failure: { _ in
                self.displayAlert("Error while Sign Up! Try later :)")
            }) { succeed in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }else{
            self.displayAlert("Your email or your password should not be correct. Your password must 8 characters lenght.")
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

    
    func displayAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
