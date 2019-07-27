//
//  UploadPhotoVC.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit
import Photos

class UploadPhotoVC: UIViewController {
    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            self.userImage.isHidden = true
        }
    }
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var selectImage: UIButton!

    var image : Image!
    var imagePrivacy : ImagePrivacy = .privateImage
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.image != nil {
            self.userImage.isHidden = false
        }
    }
    
    
    
    
    @IBAction func imagePrivacyAction(_ sender: Any) {
        guard let toggle = sender as? UISwitch else { return }
        self.imagePrivacy = (toggle.isOn) ? .privateImage : .publicImage
    }
    
    
    
    @IBAction func selectImageButtonAction(_ sender: Any) {
        
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            print("Will request authorization")
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    self.openPhotos()
                }else{
                    self.askUserToAuthrizedPhotos()
                }
            })
            
        } else {
            DispatchQueue.main.async(execute: {
                self.openPhotos()
            })
        }
        
    }
    

    
    private func askUserToAuthrizedPhotos(){
        let alert = UIAlertController(title: "!",
                                      message: "This app is not authorized to use Photo Libary.",
                                      preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "alert_photosAuth"
        
        alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                    
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    private func openPhotos(){
        DispatchQueue.main.async(execute: {
            let photoPicker = UIImagePickerController()
            photoPicker.delegate = self
            photoPicker.sourceType = .photoLibrary
            photoPicker.allowsEditing = false
            self.present(photoPicker, animated: true)
        })
    }
    
    
    
    @IBAction func uploadImageButtonAction(_ sender: Any) {
 
        self.showLoader()
        let imgVM = ImagesViewModel()
        if let imageData = self.userImage.image?.jpeg(.lowest) {
            var imageModel = Image()
            imageModel.imageData = imageData
            imageModel.userName = UserViewModel.shared.user.name
            imageModel.imgaeStatus = self.imagePrivacy.rawValue
            imgVM.uploadImage(ByUserId: UserViewModel.shared.user.id,image: imageModel)
            imgVM.completionHandler = {
                err in
                self.hideLoader()
                if err != nil {
                    self.showAlert(WithMessage: "cant`t upload image.")
                    return
                }
                self.showAlert(WithMessage: "image uploades success.")
            }
            
        }
        
        
    }
    
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        let userAuth = AuthenticationViewModel()
        userAuth.logout()
        userAuth.completionHandler = {
            err in
                   
        }
    }

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UploadPhotoVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.userImage.isHidden = false
        self.userImage.image = image
        self.viewContainer.isHidden = true
    }
    
    
    
}
