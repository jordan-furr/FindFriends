//
//  RequestsTableViewController.swift
//  FindFriends
//
//  Created by Jordan Furr on 4/22/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class RequestsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(FriendSystem.system.requestList)

        FriendSystem.system.addRequestObserver {
            print(FriendSystem.system.requestList)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FriendSystem.system.requestList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath)

        let requester = FriendSystem.system.requestList[indexPath.row]
        cell.textLabel?.text = requester.email

        return cell
    }

}
