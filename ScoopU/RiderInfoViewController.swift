//
//  RiderInfoViewController.swift
//  ScoopU
//
//  Allows the rider to input their information.  Once the information is inputted and the send
//  button is pressed it will store the information into the database and they will become an
//  official rider.
//
//  Created by Miles Singer on 12/10/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RiderInfoViewController: UIViewController {
    
    // location - the textfield where the rider will enter their location
    @IBOutlet var location: UITextField!
    // destination - the textfield where the rider will enter their destination
    @IBOutlet var destination: UITextField!
    // name - the textfield where the rider will enter their name
    @IBOutlet weak var name: UITextField!
    
    // when this view is called this function is called, like a constructor
    // it initializes the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    
    // Creates the post for the information to go into the realtime database
    @IBAction func createPost(_ sender: Any) {
        post()
    }
    
    // Allows the information to be put into the database, so it will be stored.
    func post() {
        
        let loc = location.text
        let dest = destination.text
        let nam = name.text
        
        // posts the location, destination, and name
        let post : [String : AnyObject] = ["location" : loc! as AnyObject, "destination" : dest! as AnyObject, "name" : nam! as AnyObject]
        
        // refereneces the database
        let databaseRef = FIRDatabase.database().reference()
        
        //saves current user ID
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        // adds the rider to the database with their correct information
        databaseRef.child("Riders").child(userID!).setValue(post)
    }
    
    
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Dimisses the keyboard by tapping anywhere on the screen.
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
