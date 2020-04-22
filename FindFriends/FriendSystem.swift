//
//  FriendSystem.swift
//  FindFriends
//
//  Created by Jordan Furr on 4/22/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase


class FriendSystem {
    
    static let system = FriendSystem()
    
    //base firebase reference
    let baseReference = Database.database().reference()
    
    //user firebase reference
    let userreference = Database.database().reference().child("users")

    //firebase reference to current user
    var currentUserRef: DatabaseReference {
        let id = Auth.auth().currentUser!.uid
        return userreference.child("\(id)")
    }
    
    //firebase reference to current users friend tree
    var currentUserFriends: DatabaseReference {
        return currentUserRef.child("friends")
    }
    
    //firebase reference to current users friend request tree
    var currentUserFriendRequests: DatabaseReference {
        return currentUserRef.child("requests")
    }
    
    //current users id
    var currentUsersID: String {
        let id = Auth.auth().currentUser!.uid
        return id
    }
    
    //gets current users object
    func getCurrentUserID(_ completion: @escaping (User) -> Void) {
        currentUserRef.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            let email = snapshot.childSnapshot(forPath: "email").value as! String
            let id = snapshot.key
            completion(User(userEmail: email, userID: id))
        })
    }
    
    //gets user object for specific id
    func getUser(_ userID: String, completion: @escaping (User) -> Void) {
        userreference.child(userID).observeSingleEvent(of: DataEventType.value, with:  { (snapshot) in
            let email = snapshot.childSnapshot(forPath: "email").value as! String
            let id = snapshot.key
            completion(User(userEmail: email, userID: id))
        })
    }
    
    
    //MARK: - REQUEST SYSTEM FUNCTIONS
    func sendRequestToUser(_ userID: String) {
        userreference.child(userID).child("requests").child(currentUsersID).setValue(true)
    }
    
    func removeFriend(_ userID: String) {
        currentUserRef.child("friends").child(userID).removeValue()
    }
    
    func acceptFriendRequest(_ userID: String) {
        currentUserRef.child("requests").child(userID).removeValue()
        currentUserRef.child("friends").child(userID).setValue(true)
        userreference.child(userID).child("friends").child(currentUsersID).setValue(true)
        userreference.child(userID).child("requests").child(currentUsersID).removeValue()
    }
    //***********************************************************************************************************//
    
    
    
    
    
    //MARK: ALL USERS
    
    
    //list of all users
    var userList = [User]()
    
    //adds a user observer. the completion function will fun everytime this list chnages, allowing for us to update the UI
    func addUserObserver(_ update: @escaping () -> Void) {
        FriendSystem.system.userreference.observe(DataEventType.value, with : {(snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                if email != Auth.auth().currentUser?.email! {
                    self.userList.append(User(userEmail: email, userID: child.key))
                }
            }
            update()
        })
    }
    
    //removes user observer. this should be done when leaving the view that uses the observer
    func removeUserObserver() {
        userreference.removeAllObservers()
    }
    
    
    
    
    
    
    //MARK: ALL FRIENDS
    
    var friendList = [User]()
    
    //adds a friend observer. the completion function will run everytime this list changes allowinf for us to update the UI
    func addFriendObserver(_ update: @escaping () -> Void) {
        currentUserFriends.observe(DataEventType.value, with: { (snapshot) in
            self.friendList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let id = child.key
                self.getUser(id) { (user) in
                    self.friendList.append(user)
                    update()
                }
            }
        })
    }
    
    //removes friend observer. this should be done when leaving the view that uses the observer
    func removeFriendObserver() {
        currentUserRef.removeAllObservers()
    }
    
    
    
    
    //MARK: ALL REQUESTS
    
    var requestList = [User]()
    
    //adds a friend request observer. the completion function will run everytime this list changes allowinf for us to update the UI
    func addRequestObserver(_ update: @escaping () -> Void) {
        currentUserRef.observe(DataEventType.value, with: { (snapshot) in
            self.requestList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let id = child.key
                self.getUser(id, completion: { (user) in
                    self.requestList.append(user)
                    update()
                })
            }
            // If there are no children, run completion here instead
            if snapshot.childrenCount == 0 {
                update()
            }
        })
    }

    
    //removes friend request observer. this should be done when leaving the view that uses the observer
    func removeRequestObserver() {
        currentUserFriendRequests.removeAllObservers()
    }   
}
