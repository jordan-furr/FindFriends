//
//  Error.swift
//  FindFriends
//
//  Created by Jordan Furr on 4/22/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation
import FirebaseAuth

class Error {
    
    var errorMessage: String!
    
    init(error: AuthErrorCode) {
        switch error {
        case .invalidEmail:
            errorMessage = "Whoops that is not a valid email"
        case .userDisabled:
            errorMessage = "this user is blocked"
        case .wrongPassword:
            errorMessage = "this email or username is incorrect"
        case .emailAlreadyInUse:
            errorMessage = "there is already an account associated with this email"
        case .weakPassword:
            errorMessage = "this password is too weak. try something stronger"
        default:
        errorMessage = "Looks like something went wrong. please try again"
        }
    }
}
