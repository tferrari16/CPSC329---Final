//
//  RiderInfoViewController.swift
//  ScoopU
//
//  Created by Miles Singer on 12/10/16.
//  Copyright © 2016 ScoopU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class RiderInfoViewController: UIViewController {

    @IBOutlet var location: UITextField!
    
    @IBOutlet var destination: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        post()

        // Do any additional setup after loading the view.
    }
    
    
    func post() {
        
        //let loc = location
        //let dest = destination
        
        
        
        let post : [String : AnyObject] = ["location" : location.text! as AnyObject, "destination" : destination.text! as AnyObject]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Riders").childByAutoId().setValue(post)
        
        print("Location: " + location.text!)
        print("Destination: " + destination.text!)
        
        
        
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
