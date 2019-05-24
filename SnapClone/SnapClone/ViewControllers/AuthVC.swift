//
//  AuthVC.swift
//  SnapClone
//
//  Created by Dhawal Majithia on 5/23/19.
//  Copyright © 2019 Dhawal Majithia. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthVC: UIViewController {
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if let _ = Auth.auth().currentUser{
            //user is already logged in, so segue to main view
            self.segueToMain()
        }
    }
    @IBAction func TappedDone(_ sender: Any) {
        if !self.EmailText.text!.isEmpty && !self.PasswordText.text!.isEmpty {
            let email = self.EmailText.text!
            let password = self.PasswordText.text!
            Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
                if error != nil {
                    //user has not signed up, sign them up
                    Auth.auth().createUser(withEmail: email, password: password, completion: {(rResult, rError) in
                        //segue to create username
                        self.segueToCreateUsername()
                    })
                }
                else{
                    //segue to main
                    self.segueToMain()
                }
            })
        }
    }
    
    func segueToMain() {
        self.performSegue(withIdentifier: "segueToMain", sender: self)
    }
    
    func segueToCreateUsername() {
        self.performSegue(withIdentifier: "segueToCreateUsername", sender: self)
    }
}
