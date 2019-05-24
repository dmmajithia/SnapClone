//
//  SearchVC.swift
//  SnapClone
//
//  Created by Dhawal Majithia on 5/23/19.
//  Copyright © 2019 Dhawal Majithia. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ResultsTableView: UITableView!
    @IBOutlet weak var UsernameText: UITextField!
    var usernames: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usernames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")
        cell?.textLabel?.text = self.usernames[indexPath.item]
        return cell!
    }
    @IBAction func TappedFind(_ sender: Any) {
        self.view.endEditing(true)
        let username = self.UsernameText.text!
        if !username.isEmpty {
            let ref = Database.database().reference()
            ref.child("usernames").queryOrderedByKey().queryStarting(atValue: username).observeSingleEvent(of: .value, with: {(snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    self.usernames = value.allKeys as? [String]
                    print(self.usernames)
                }
            })
            
        }
    }
    
    func showAddAction(username: String){
        let defaultAction = UIAlertAction(title: "Agree",
                                          style: .default) { (action) in
                                            // Respond to user selection of the action.
        }
        let cancelAction = UIAlertAction(title: "Disagree",
                                         style: .cancel) { (action) in
                                            // Respond to user selection of the action.
        }
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: "Terms and Conditions",
                                      message: "Click Agree to accept the terms and conditions.",
                                      preferredStyle: .alert)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
            // The alert was presented
        }
    }
}
