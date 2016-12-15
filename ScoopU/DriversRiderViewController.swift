//
//  DriversRiderViewController.swift
//  ScoopU
//
//  Allows the driver to access the database and see the riders information.  When the driver
//  clicks the here button the rider will be notified the driver is here.
//
//  Created by Taylor Ferrari on 12/14/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

// Creates a rider structure
struct Riders {
    let locations : String!
    let destinations : String!
    let names : String!
}

class DriversRiderViewController: UIViewController {
    
    // riderName, riderLocation and riderDestination - labels with rider information
    
    @IBOutlet weak var riderName: UILabel!
    @IBOutlet weak var riderLocation: UILabel!
    @IBOutlet weak var riderDestination: UILabel!
    
    
    @IBOutlet var hereButton: UIButton!
    
    var riderArray = [Riders]()
    
    // when this view is called this function is called, like a constructor
    // it initializes the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseRef = FIRDatabase.database().reference()
        
        //saves current user ID
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        
        databaseRef.child("Active Ride").queryOrdered(byChild: userID!).observe(.childAdded, with: {
            snapshot in
            
            let loc = snapshot.childSnapshot(forPath: "location").value as! String
            let dest = snapshot.childSnapshot(forPath: "destination").value as! String
            let name = snapshot.childSnapshot(forPath: "name").value as! String
            
            self.riderArray.insert(Riders(locations:  loc, destinations: dest, names : name), at: 0)
            
            let label1 = self.riderName
            label1?.text = self.riderArray[0].names
            
            let label2 = self.riderLocation
            label2?.text = self.riderArray[0].locations
            
            let label3 = self.riderDestination
            label3?.text = self.riderArray[0].destinations
            
        })
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Store information in the database when the here button is pressed.
    @IBAction func hereButtonPressed(_ sender: Any) {
        
        let databaseRef = FIRDatabase.database().reference()
        
        
        let currentDriver = FIRAuth.auth()?.currentUser?.uid
        
        databaseRef.child("Active Ride").child(currentDriver!).removeValue()
        databaseRef.child("Rider").child("p8D1Aae61VQ3hQaQedRqMCiepSm1").removeValue()
        
    }
}
