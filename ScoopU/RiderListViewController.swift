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
    let names : String!
}

class RiderListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var picker: UIPickerView!
    
    var riders = [Rider]()
    var pickerData : [String] = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let databaseRef = FIRDatabase.database().reference()
        
       
        //saves current user ID
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        databaseRef.child("Riders").queryOrdered(byChild: userID!).observe(.childAdded, with: {
            snapshot in
            
           
            let dest = snapshot.childSnapshot(forPath: "destination").value as! String
            let loc = snapshot.childSnapshot(forPath: "location").value as! String
            let name = snapshot.childSnapshot(forPath: "name").value as! String
            
            
            self.riders.insert(Rider(locations: loc, destinations: dest, names : name), at: 0)
            self.pickerData.insert(name, at: 0)
            
            self.picker.delegate = self
            self.picker.dataSource = self
            
            self.tableView.reloadData()
            
            
            
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    //flexible number of cells in table (number of riders in database)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riders.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let label1 = cell.viewWithTag(1) as! UILabel
        label1.text = riders[indexPath.row].names
        
        let label2 = cell.viewWithTag(2) as! UILabel
        label2.text = riders[indexPath.row].locations
        
        let label3 = cell.viewWithTag(3) as! UILabel
        label3.text = riders[indexPath.row].destinations
        
        return cell
        

    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
}
