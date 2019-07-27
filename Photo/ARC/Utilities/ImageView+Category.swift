//
//  ImageView+Category.swift
//  Forma
//
//  Created by Yahia El-Dow on 7/21/18.
//  Copyright © 2018 P-Codes. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
        func loadImageFromUrl (imgUrl : String){
            let encoding : String = imgUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let url = URL(string: encoding )
            let processor = DownsamplingImageProcessor(size: self.frame.size) >> RoundCornerImageProcessor(cornerRadius: 0)
            self.kf.indicatorType = .activity

            self.kf.setImage(
                with: url,
                placeholder: UIImage(named: "default-image"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    break
                case .failure(let error):
                    self.image = UIImage(named: "default-image")
                    print("Job failed: \(error.localizedDescription)")
                    break
                }
            }
            
            
        }
}




extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
