//
//  CustomButton.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    @IBInspectable var circleButton : Bool = false {
        didSet{
            if circleButton == true {
                self.layer.cornerRadius = 0.5 * self.bounds.size.width
                self.clipsToBounds = true

            }
        }
    }

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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initfontStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initfontStyle()
    }
    
    
    private func initfontStyle(){
        let fontSize: CGFloat = self.titleLabel?.font.pointSize ?? 18
        self.titleLabel?.font = UIFont(name: FIXED_FONT_NAME, size:fontSize)
        
    }
    
    

    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
