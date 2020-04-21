//
//  HomeViewController.swift
//  FindFriends
//
//  Created by Jordan Furr on 4/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);

        // Do any additional setup after loading the view.
    }
    
   @IBAction func logOutAction(_ sender: Any) {
       do {
              try Auth.auth().signOut()
          }
       catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
          }
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let initial = storyboard.instantiateInitialViewController()
          UIApplication.shared.keyWindow?.rootViewController = initial
   }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}