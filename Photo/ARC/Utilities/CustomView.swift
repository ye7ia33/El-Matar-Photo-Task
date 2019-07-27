//
//  CustomView.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {
    
    @IBInspectable var cornerRadius : CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
