//
//  ViewController.swift
//  ScoopU
//
//  Allows a user to sign up for an account on the app.  They can enter an
//  email
//  and password and it will be stored in the databse.
//
//  Created by Taylor Ferrari on 12/4/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth


class RegisterViewController: UIViewController, UITextFieldDelegate {
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // Create account will create a useres account in the database when the sign up button
    // pressed.
    @IBAction func createAccounts(_ sender: Any) {
        
        FIRAuth.auth()?.createUser(withEmail: email.text!, password:password.text!, completion: {
            user, error in
            
            // if there was no error, call login
            if error != nil {
                self.login()
            } else {
                //everything went smoothly
                print("user created")
                self.login()
            }
        })
    }
    
    
    // Function that is called when the user logs in.  When the email and password are incorrect
    // an error will be printed.
    func login() {
        
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
