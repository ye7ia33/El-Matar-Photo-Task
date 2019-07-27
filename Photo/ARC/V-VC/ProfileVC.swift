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

    @IBOutlet weak var lblUserName: CustomLabel!{
        didSet{
            self.lblUserName.text = UserViewModel.shared.user.name
        }
    }
    
    
    
    fileprivate let collectionViewIdentifier  = "PhotoCustomCell"
    @IBOutlet weak var profileCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PhotoCustomCell" , bundle: nil)
        self.profileCollectionView.register(nib, forCellWithReuseIdentifier: self.collectionViewIdentifier)
         self.showLoader()
        self.imageVM.getImages(privacy: .userImage ,byUserId: UserViewModel.shared.user.id)
        self.imageVM.completionHandler = {
            err in
            self.profileCollectionView.reloadData()
            self.hideLoader()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // SEG
                performSegue(withIdentifier: "goToEditPhoto", sender: nil)
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
