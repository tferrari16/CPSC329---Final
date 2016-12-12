//
//  RiderListViewController.swift
//  ScoopU
//
//  Created by Miles Singer on 12/11/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


struct Rider {
    let locations : String!
    let destinations : String!
}

class RiderListViewController: UIViewController {
    
    var riders = [Rider]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let databaseRef = FIRDatabase.database().reference()
        
       
        //saves current user ID
        let userID = FIRAuth.auth()?.currentUser?.uid
        
//        databaseRef.observe(FIRDataEventType.value, with: { (snapshot) in
//            
//        let locationT = snapshot.value as? [String: AnyObject] ?? [:]
//            
//        print("printing: ", locationT)
//        
//        })
        
        databaseRef.child("Riders").queryOrdered(byChild: userID!).observe(.childAdded, with: {
            snapshot in
            
           
            let dest = snapshot.childSnapshot(forPath: "destination").value as! String
            let loc = snapshot.childSnapshot(forPath: "location").value as! String
            
            
        
            self.riders.insert(Rider(locations: loc, destinations: dest), at: 0)
            
            
            
            print("printing: ", dest)
            print("printing: ", loc)
            
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    //flexible number of cells in table (number of riders in database)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riders.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = riders[indexPath.row].locations
        
        let label3 = cell?.viewWithTag(3) as! UILabel
        label3.text = riders[indexPath.row].destinations
        
        return cell!
        

    }
    
}
