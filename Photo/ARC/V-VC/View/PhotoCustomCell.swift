//
//  PhotoCustomCell.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit

class PhotoCustomCell: UICollectionViewCell {
    @IBOutlet weak var usernameView: UIView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: CustomLabel!{
        didSet{
            self.userName.text = ""
        }
    }
    
    func initViewData(image : Image, viewStyle : DisplayView) {
        
     
        if viewStyle == .grid {
            if self.usernameView != nil{
                self.usernameView.removeFromSuperview()
            }
           
        }else{
          
            self.userName.text = image.userName

            
        }
         self.userImage.loadImageFromUrl(imgUrl:image.imgUrl ?? "")
    }

    
    
}
