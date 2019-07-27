//
//  ViewController+Category.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {

    
    func showAlert(WithMessage msg : String , buttonTitle : String = "OK") {
        let alert = UIAlertController(title: "!", message: msg , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func showLoader() {
        
        view.isUserInteractionEnabled = false
        let dimmedView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        dimmedView.tag = -1991
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: view.frame.midX - 50 / 2,
                                                                          y: view.frame.midY - 50 / 2,
                                                                          width: 50 , height: 50), color: .white)
        activityIndicatorView.type = .ballClipRotatePulse
        dimmedView.addSubview(activityIndicatorView)
        view.addSubview(dimmedView)
        activityIndicatorView.startAnimating()
    }
    
    
    func hideLoader() {
        
        self.view.subviews.forEach{
            if $0.tag == -1991 {
                view.isUserInteractionEnabled = true
                $0.removeFromSuperview()
                return
            }
            
        }
    }
    
    

}
