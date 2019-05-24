//
//  CreateUsernameVC.swift
//  SnapClone
//
//  Created by Dhawal Majithia on 5/23/19.
//  Copyright © 2019 Dhawal Majithia. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameVC: UIViewController {
    
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var UsernameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    @IBAction func TappedDone(_ sender: Any) {
        //first check if username textfield is not empty
        if UsernameText.text!.isEmpty {
            return
        }
        let username = UsernameText.text!
        let ref = Database.database().reference()
        ref.child("usernames").child(username).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary {
                //username already exists
                self.ErrorLabel.isHidden = false
            }
            else {
                //add [username:uid] to "usernames" in database, then segue to main view
                ref.child("usernames").child(username).setValue(Auth.auth().currentUser?.uid)
                //segue to main
                self.segueToMain()
            }
        })
    }
    func segueToMain() {
        self.performSegue(withIdentifier: "segueToMain", sender: self)
    }
}
