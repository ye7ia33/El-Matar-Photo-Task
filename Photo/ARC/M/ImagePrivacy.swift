//
//  ImagePrivacy.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/26/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import Foundation

enum ImagePrivacy {
    case publicImage
    case privateImage

    var rawValue: Int {
        switch self {
        case .privateImage: return 0
        case .publicImage: return 1
        }
    }
    
    
}
