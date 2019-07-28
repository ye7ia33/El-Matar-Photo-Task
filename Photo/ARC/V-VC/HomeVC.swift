//
//  HomeVC.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit
enum DisplayView {
    case grid
    case list
}
class HomeVC: UIViewController {
    fileprivate let collectionViewIdentifier  = "PhotoCustomCell"
   
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    fileprivate let imageVM = ImagesViewModel()
    
    fileprivate var refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "homeView"
        self.homeCollectionView.accessibilityIdentifier = "homeCollectionView"
        
        
        let nib = UINib(nibName: "PhotoCustomCell" , bundle: nil)
        self.homeCollectionView.register(nib, forCellWithReuseIdentifier: self.collectionViewIdentifier)
        
        self.refreshControl.addTarget(self, action: #selector(featchData), for: .allEvents)
        self.homeCollectionView.insertSubview(refreshControl , at: 0)

        self.featchData()
        self.imageVM.completionHandler = {
            err in
            self.homeCollectionView.reloadData()
            self.hideLoader()
        }
       
    }
    
    
    @objc private func featchData(){
            self.showLoader()
            self.imageVM.getImages(privacy: .publicImage)
            self.refreshControl.endRefreshing()
        
 
    }

}
extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageVM.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewIdentifier, for: indexPath) as! PhotoCustomCell
        if self.imageVM.imageList.count > indexPath.item {
            let image = self.imageVM.imageList[indexPath.item]
            cell.initViewData(image: image, viewStyle:.list)

        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // SEG
//        performSegue(withIdentifier: "showDetails", sender: self.categoryVM.categoryListArray[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
 
    
}
