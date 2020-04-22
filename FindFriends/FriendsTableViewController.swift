//
//  FriendsTableViewController.swift
//  FindFriends
//
//  Created by Jordan Furr on 4/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = UINavigationBar.appearance()
        nav.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        FriendSystem.system.addFriendObserver {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FriendSystem.system.friendList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        
        let friend = FriendSystem.system.friendList[indexPath.row]
        cell.textLabel?.text = friend.email
       // cell.detailTextLabel?.text = friend.id
        return cell
    }
}
