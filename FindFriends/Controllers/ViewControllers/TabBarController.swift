//
//  TabBarController.swift
//  FindFriends
//
//  Created by Jordan Furr on 4/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let nav = UINavigationBar.appearance()
        nav.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        // Do any additional setup after loading the view.
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
