//
//  User.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    static let shared = User()
    
    var id : String? {
        get{
            return Auth.auth().currentUser?.uid
        }
    }
    
    var name : String? {
        get{
            return Auth.auth().currentUser?.displayName
        }
    }
    
    
    
    
    
}
