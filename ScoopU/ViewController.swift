//
//  ViewController.swift
//  ScoopU
//
//  Created by Taylor Ferrari on 12/4/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit

import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //called by the register button - creates an account in the Firebase database
    @IBAction func createAccount(_ sender: Any) {

        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: {
            
            user, error in
            
            //if there was no error, call login
            
            if error != nil {
     
                self.login()
 
                
            } else {

                //everything went smoothly
                
                print("user created")
                
                self.login()
            }
            

        })

        
    }

    //function called when log In button is pressed
    
    @IBAction func logInUser(_ sender: Any) {
         self.login()
    }
   
    
    //function that is called when the user logs in - if the email/password is incorrect, print error
    
    func login() {
        
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: {
            
            user, error in
            
            if error != nil{
                
                print("password / username is incorrect")
                
            } else {
                
                print("Huzzah!")
                
                self.performSegue(withIdentifier: "Driver or Rider", sender: self)
                
                


            }

        })
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
