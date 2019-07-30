//
//  ProfileVC.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    fileprivate let imageVM = ImagesViewModel()
    @IBOutlet weak var navBarView: UINavigationBar!
    
    @IBOutlet weak var lblUserName: CustomLabel!{
        didSet{
            self.lblUserName.text = User.shared.name ?? ""
        }
    }

    fileprivate let collectionViewIdentifier  = "PhotoCustomCell"
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PhotoCustomCell" , bundle: nil)
        self.profileCollectionView.register(nib, forCellWithReuseIdentifier: self.collectionViewIdentifier)
         self.showLoader()
        self.imageVM.getImages(privacy: .privateImage ,byUserId: User.shared.id)
        self.imageVM.completionHandler = {
            err in
            self.profileCollectionView.reloadData()
            self.hideLoader()
        }
        
    }
    
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout", message: "are you sure?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            AuthenticationViewModel().logout()
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginNav = storyboard.instantiateViewController(withIdentifier: "loginNVC") as! UINavigationController
            self.present(loginNav, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "No", style: .default) { (_) in }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    
}

extension ProfileVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageVM.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewIdentifier, for: indexPath) as! PhotoCustomCell
        let image = self.imageVM.imageList[indexPath.item]
        cell.initViewData(image: image, viewStyle: .grid )
        return cell
    }
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    
}
