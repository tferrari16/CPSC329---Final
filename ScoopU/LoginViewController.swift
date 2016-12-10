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

class LoginViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

}
