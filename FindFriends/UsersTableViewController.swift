//
//  UsersTableViewController.swift
//  FindFriends
//
//  Created by Jordan Furr on 4/22/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        FriendSystem.system.userList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let user = FriendSystem.system.userList[indexPath.row]
        
        cell.textLabel?.text = user.email
        //cell.detailTextLabel?.text = user.id
        // Configure the cell...

        return cell
    }
}
