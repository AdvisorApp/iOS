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
    
    func isEnoughComplete(email: String, password: String) -> Bool {
        return (email.isValidEmail) && (password.characters.count >= 8)
    }
    
    @IBAction func signup(sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let remoteId = remoteIdTextField.text!
        
    
        if (isEnoughComplete(email, password: password)) {
            UserService.signup(firstName, lastName: lastName, email: email, password: password, remoteId: remoteId, failure: { _ in
                Alert.show("Error while Sign Up! Your email should be already used. Otherwise, try later 🙂", viewController: self)
            }) { succeed in
                
                let alert = UIAlertController(title: "Success ! You successfully signed up !", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { _ in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }))
                self.presentViewController(alert, animated: true, completion: nil)

            }
        } else {
            Alert.show("Your email or your password should not be correct. Your password must 8 characters lenght.", viewController: self)
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
