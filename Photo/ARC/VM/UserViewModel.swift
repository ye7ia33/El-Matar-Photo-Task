//
//  UserViewModel.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/26/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit
import FirebaseAuth
class UserViewModel: ViewModel {

   static let shared = UserViewModel()
    
    let user : User = {
        let user = User(id: Auth.auth().currentUser?.uid ?? "", name: Auth.auth().currentUser?.displayName ?? "", images: nil)
        return user 
    }()
    
    
    
}
