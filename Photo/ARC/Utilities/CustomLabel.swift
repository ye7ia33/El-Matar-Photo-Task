//
//  CustomLabel.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit
@IBDesignable
class CustomLabel: UILabel {
    
   
//    @IBInspectable var fontName : String  {
//        set{
//        }
//        get{
//            return self.FIXED_FONT_NAME
//        }
//    }
////
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initfontStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         self.initfontStyle()
    }
    
    
    private func initfontStyle(){
        self.font = UIFont(name: FIXED_FONT_NAME, size:self.font.pointSize )
    }
}
