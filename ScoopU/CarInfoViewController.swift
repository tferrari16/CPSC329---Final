//
//  CarInfoViewController.swift
//  ScoopU
//
//  Created by Miles Singer on 12/11/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CarInfoViewController: UIViewController {
    
    
    @IBOutlet var makeAndModel: UITextField!
    @IBOutlet var year: UITextField!
    @IBOutlet var plateNumber: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func sendCarInfo(_ sender: Any) {
        
        post()
        
    }
    
        
        func post() {
            
            let mAm = makeAndModel.text
            let years = year.text
            let plate = plateNumber.text
            
            
            
            let post : [String : AnyObject] = ["Make and Model" : mAm! as AnyObject, "Year" : years! as AnyObject, "Plate Number" : plate! as AnyObject]
            
            let databaseRef = FIRDatabase.database().reference()
            
            //saves current user ID
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            databaseRef.child("Car Information").child(userID!).setValue(post)
            
            
        }

        
        
    }
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

