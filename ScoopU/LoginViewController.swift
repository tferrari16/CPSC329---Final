//
//  LoginViewController.swift
//  ScoopU
//
//  Created by Miles Singer on 12/10/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
     
        
        self.email.delegate = self
        self.password.delegate = self
        
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: {
            
            user, error in
            
            if error != nil{
                
                print("password / username is incorrect")
                
            } else {
                
                print("Huzzah!")
                
                self.performSegue(withIdentifier: "login", sender: self)
                
                
                
                
            }
            
        })

        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
