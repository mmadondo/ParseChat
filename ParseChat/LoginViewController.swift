//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Malvern Madondo on 6/26/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    let loginAlertController = UIAlertController(title: "Invalid Input", message: "Please enter username AND password", preferredStyle: .alert)
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTxt.text
        //newUser.email = emailLabel.text
        newUser.password = passwordTxt.text
        
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty{
            self.present(self.loginAlertController, animated: true)
            
        } else{
            // call sign up function on the object to sign up the user asynchronously and avoid duplicates
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                }
            }
        }
        

    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let username = usernameTxt.text ?? ""
        let password = passwordTxt.text ?? ""
        
        /*
         Makes an asynchronous request to log in a user with specified credentials.
         *Returns an instance of the successfully logged in PFUser.
         *This also caches the user locally so that calls to PFUser.currentUser() will use the latest logged in user.
         *@param:  - username: The username of the user.
                   - password: The password of the user.
         */
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        loginAlertController.addAction(OKAction)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
