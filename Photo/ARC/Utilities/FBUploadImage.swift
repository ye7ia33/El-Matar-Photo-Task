//
//  FBUploadImage.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/26/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import Foundation
import Firebase


class FBUploadImage {
    let storage = Storage.storage()
    

    func upload(){
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("images")
        var spaceRef = storageRef.child("images/space.jpg")


    }
}
