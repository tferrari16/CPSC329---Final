//
//  DriverInfoViewController.swift
//  ScoopU
//
//  Allows the rider to see the drivers information when the driver selects that rider.
//  A label will appear when the driver presses the here button.
//
//  Created by Taylor Ferrari on 12/14/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

// Creates a driver structure
struct Driver {
    let names : String!
    let cars : String!
    let licenses : String!
}


class DriverInfoViewController: UIViewController {
    
    @IBOutlet var driverName: UILabel!
    
    @IBOutlet var carType: UILabel!
    
    @IBOutlet var plateNumber: UILabel!
    
    @IBOutlet var driverIsHere: UILabel!
    
    // driverName, carTyoe, plateNumber and driverIsHere - labels that will allow
    // the rider to see the information about the driver
    
    // driverArray - all of the drivers
    var driverArray = [Driver]()
    
    
    // when this view is called this function is called, like a constructor
    // it initializes the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseRef = FIRDatabase.database().reference()
        
        //saves current user ID
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        databaseRef.child("Active Ride").queryOrdered(byChild: userID!).observeSingleEvent(of: .childAdded, with: { snapshot in
            
            let driverID = snapshot.childSnapshot(forPath: "DriverID").value as! String
            
            print(driverID)
            
            
            databaseRef.child("Car Information").queryOrdered(byChild: userID!).observe(.childAdded, with: {
                snapshot in
                
                
                if(snapshot.key == driverID) {
                    
                    let car = snapshot.childSnapshot(forPath: "Make and Model").value as! String
                    let plate = snapshot.childSnapshot(forPath: "Plate Number").value as! String
                    let name = snapshot.childSnapshot(forPath: "Name").value as! String
                    
                    self.driverArray.insert(Driver(names:  name, cars: car, licenses : plate), at: 0)
                    
                    let label1 = self.driverName
                    label1?.text = self.driverArray[0].names
                    
                    let label2 = self.carType
                    label2?.text = self.driverArray[0].cars
                    
                    let label3 = self.plateNumber
                    label3?.text = self.driverArray[0].licenses
                    
                    print(self.driverArray)
                    
                }
            })
        })
    }
    
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
