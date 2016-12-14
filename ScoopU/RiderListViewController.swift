//
//  RiderListViewController.swift
//  
//
//  Created by Taylor Ferrari on 12/14/16.
//
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

struct Pick {
    let Pnames : String!
    let Plocation : String!
    let Pdestination : String!
}

class RiderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var selectRider: UIButton!
    
    @IBOutlet var tableView: UITableView!
   
    @IBOutlet var picker: UIPickerView!
    
    //array of struct Pick, which has the name of the user, and the userID
    var pickerData : [Pick] = [Pick]()
    //var pickerData : [String] = [String]()
    
    var riders = [Rider]()
    
    
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
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //flexible number of cells in table (number of riders in database)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riders.count
        
    }
    
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].Pnames
        
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        
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
    
    
    //    //tells which cell is selected
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    //
    //        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
    //
    //
    //
    //
    //
    //
    //
    //
    //    }
    
    
    




}
