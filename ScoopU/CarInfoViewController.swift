//
//  CarInfoViewController.swift
//  ScoopU
//
//  Allows the driver to input their information.  Once the information is inputted and the enter
//  button is pressed it will store the information into the database and they will become an
//  official driver.
//
//  Created by Miles Singer, Taylor Ferrari, Krista Anken and Sam Ash on 12/11/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CarInfoViewController: UIViewController {
    
    // makeAndModel, plateNumber and name - all used to create a driver
    @IBOutlet var makeAndModel: UITextField!
    @IBOutlet var plateNumber: UITextField!
    @IBOutlet var name: UITextField!
    
    // when this view is called this function is called, like a constructor
    // it initializes the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //  Sends the car information to the database.
    @IBAction func sendCarInfo(_ sender: Any) {
        
        post()
        
    }
    
    // Allows the information to be put into the database, so it will be stored.
    func post() {
        
        let mAm = makeAndModel.text
        let plate = plateNumber.text
        let names = name.text
        
        // posts the make and model, plate number and name
        let post : [String : AnyObject] = ["Make and Model" : mAm! as AnyObject, "Plate Number" : plate! as AnyObject, "Name" : names! as AnyObject]
        
        // refereneces the database
        let databaseRef = FIRDatabase.database().reference()
        
        //saves current user ID
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        // adds the rider to the database with their correct information
        databaseRef.child("Car Information").child(userID!).setValue(post)
    }
    
    // Dimisses the keyboard by tapping anywhere on the screen.
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
