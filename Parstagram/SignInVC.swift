//
//  SignInVC.swift
//  Parstagram
//
//  Created by Jesus Andres Bernal Lopez on 1/10/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class SignInVC: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { [weak self] user, error in
            guard let self = self else { return }
            if user != nil {
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
                self.performOkayAlertWith(title: "Error", message: error!.localizedDescription)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        guard usernameTextField.text!.count >= 3 else {
            performOkayAlertWith(title: "Invalid username", message: "Please choose a username with more than 5 characters and try again.")
            return
        }
        guard passwordTextField.text!.count > 6 else {
            performOkayAlertWith(title: "Weak password", message: "Please choose a strong password and try again")
            return
        }
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        
        user.signUpInBackground { [weak self] success, error in
            guard let self = self else { return }
            if success {
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
                self.performOkayAlertWith(title: "Internal Server Error", message: "Please try again later")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
