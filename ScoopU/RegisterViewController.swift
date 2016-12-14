//
//  ViewController.swift
//  ScoopU
//
//  Created by Taylor Ferrari on 12/4/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth


class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
      
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //called by the register button - creates an account in the Firebase database
        @IBAction func createAccounts(_ sender: Any) {
        
        FIRAuth.auth()?.createUser(withEmail: email.text!, password:password.text!, completion: {
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
   
    
    //function that is called when the user logs in - if the email/password is incorrect, print error
    
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
    
    -(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [email resignFirstResponder];
    return YES;
    }
    
  //  func textFieldShouldReturn->(UITextField, *);textField {
    //    if (textField == email) {
      //      [email, resignFirstResponder];
        //    [password, becomeFirstResponder];
       // }
        //else if(textField == password){
          //  [descriptionField, resignFirstResponder];
        //}
        //return YES;
   // }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
