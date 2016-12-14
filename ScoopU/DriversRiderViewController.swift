//
//  DriversRiderViewController.swift
//  ScoopU
//
//  Created by Taylor Ferrari on 12/14/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct Riders {
    let locations : String!
    let destinations : String!
    let names : String!
}

class DriversRiderViewController: UIViewController {

    @IBOutlet weak var riderName: UILabel!
    @IBOutlet weak var riderLocation: UILabel!
    @IBOutlet weak var riderDestination: UILabel!

    var riderArray = [Riders]()
    
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
}
