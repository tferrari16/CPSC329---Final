//
//  RiderListViewController.swift
//  ScoopU
//
//  Allows the rider in input their information.  Once the information is inputted and the send
//  button is pressed it will store the information into the database and they will become an
//  official rider.
//
//  Created by Miles Singer, Taylor Ferrari, Krista Anken and Sam Ash on 12/10/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

// Creates a Rider structure
struct Rider {
    let locations : String!
    let destinations : String!
    let names : String!
}

// Creates a Pick structure
struct Pick {
    let Pnames : String!
    let Plocation : String!
    let Pdestination : String!
}

class RiderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // tableView, picker and selectRider - used for a driver to select a rider
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var picker: UIPickerView!
    
    @IBOutlet var selectRider: UIButton!
    
    //array of struct Pick, which has the name of the user, and the userID
    var pickerData : [Pick] = [Pick]()
    //var pickerData : [String] = [String]()
    
    var riders = [Rider]()
    
    
    // when this view is called this function is called, like a constructor
    // it initializes the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseRef = FIRDatabase.database().reference()
        
        
        //saves current user ID
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        
        databaseRef.child("Riders").queryOrdered(byChild: userID!).observe(.childAdded, with: {
            snapshot in
            
            let loc = snapshot.childSnapshot(forPath: "location").value as! String
            let dest = snapshot.childSnapshot(forPath: "destination").value as! String
            let name = snapshot.childSnapshot(forPath: "name").value as! String
            
            self.riders.insert(Rider(locations:  loc, destinations: dest, names : name), at: 0)
            
            self.pickerData.insert(Pick(Pnames : name, Plocation : loc, Pdestination : dest), at: 0)
            
            self.picker.delegate = self
            self.picker.dataSource = self
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            
            self.tableView.reloadData()
        })
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Flexible number of cells in table (number of riders in database)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riders.count
        
    }
    
    // Contains the labels that will be in every single cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let label1 = cell.viewWithTag(1) as! UILabel
        label1.text = riders[indexPath.row].names
        
        let label2 = cell.viewWithTag(2) as! UILabel
        label2.text = riders[indexPath.row].locations
        
        let label3 = cell.viewWithTag(3) as! UILabel
        label3.text = riders[indexPath.row].destinations as String
        
        
        return cell
    }
    
    
    // Represents the number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Generates the number of components in the picker.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].Pnames
        
    }
    
    // Catpure the picker view selection
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        
        let name = pickerData[row].Pnames
        let loc = pickerData[row].Plocation
        let dest = pickerData[row].Pdestination
        let driverID = userID
        
        let riderScoop : [String : AnyObject] = ["name" : name! as AnyObject, "location" : loc! as AnyObject, "destination" : dest as AnyObject, "DriverID" : driverID as AnyObject]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Active Ride").child(userID!).setValue(riderScoop)
    }
    
    
    @IBAction func selectRiderPressed(_ sender: Any) {
        
        
    }
}
