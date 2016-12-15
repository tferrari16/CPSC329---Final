//
//  LoginViewController.swift
//  ScoopU
//
//  Takes the entered email and password and chekcs what was entered with
//  the database.
//  If it matches then it will let the user login, if it does not then the
//  user will not
//  get logge in and will need to sign up.
//
//  Created by Miles Singer, Taylor Ferrari, Krista Anken and Sam Ash on
//  12/10/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // email - the textfield where the user will enter their email
    @IBOutlet var email: UITextField!
    // password - the textfield where the user will enter their password
    @IBOutlet var password: UITextField!
    
    // when this view is called this function is called, like a constructor
    // it initializes the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Login gives functionality to the login button.  It takes the inforamtion
    // the user entered in email and password and then access' the database.
    // If the inputted information is in the database, then it will let the
    // user log in and go to the next view controller.
    @IBAction func login(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: {
            
            user, error in
            
            if error != nil{
                print("password / username is incorrect")
            } else {
                self.performSegue(withIdentifier: "login", sender: self)
            }
        })
    }
    
    // Dimisses the keyboard by tapping anywhere on the screen.
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
