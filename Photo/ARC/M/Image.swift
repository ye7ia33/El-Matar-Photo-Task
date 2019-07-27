//
//  Image.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import Foundation

struct Image : Codable {
   
    var imgUrl : String?
    var imgaeStatus : Int?
    var userName : String?
    
    var imageData : Data? = nil
    
    enum CodingKeys: String, CodingKey {
        case imgaeStatus = "status"
        case imgUrl = "url"
        case userName = "userName"
    }
    
    
    
}
