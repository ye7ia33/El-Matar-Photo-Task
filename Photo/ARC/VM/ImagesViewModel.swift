//
//  ImagesViewModel.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/26/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit
import Firebase


class ImagesViewModel: ViewModel {
    
    var imageList = [Image]()
    private let userRef = Firestore.firestore().collection("users")
    
    /*** GET IMAGE DEPINCE ON ImagePrivacy TYPE {PUBLIC / PRIVATE}
     * IF NEED USER IMAGE PROFILE PASS  userImage AS ImagePrivacy TYPE
     * public JUST RETIRIVE ONLY PUBLIC USER IMAGE
     * @param privacy = ImagePrivacy, userId = User.id
     *      //Call Method
            getImages(privacy: .userImage ,byUserId: UserViewModel.shared.user.id)
     */
 
    func getImages(privacy : ImagePrivacy , byUserId userId : String? = nil){
        
        if privacy == .userImage {
            if let id = userId { self.getUserImages(byUserID:id) }
            return
        }
        self.getPublicImages()
    }
    
    
    func uploadImage(ByUserId uId : String , image : Image){
        guard let imageData = image.imageData else{return}
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imgName =  "\(uId)_\(arc4random())"
        let imagesRef = storageRef.child("usersImages/\(imgName).jpeg")
        
        imagesRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                self.completionHandler(error)
                return
            }
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                
                print(downloadURL.absoluteString)
                print(url)  
            }
            
            
            
//            self.insertNewImageToUser(byUserID: uId, imgStatus: image.imgaeStatus ?? 0, url: metadata.path ?? "", userName: image.userName ?? "")
        }
    }
    
    
    //TODO: GET ALL USERS IMAGES
    /**
        HOME VIEW IMAGE DISPLAY
     */
    /***
     NOT MANDATORY USER ID
     JUST CALL METHOD..
    */
   private func getPublicImages(){
    
        userRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                self.completionHandler(err)
            } else {
                self.imageList.removeAll()
                for document in querySnapshot!.documents {
                    
                    self.userRef.document(document.documentID).collection("images").whereField("status", isEqualTo: 1).getDocuments(completion: {(querySnapshot, err) in
                        if err != nil {
                            self.completionHandler(err)
                            return
                        }
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            if let image = self.handelImageModel(imgObject: data) {
                                self.imageList.append(image)
                            }
                            self.completionHandler(nil)
                        }
                    })
                }
            }
        }
    }
    
    // TODO: GET USER IMAGE BY USER ID
    /**
        USER PROFILE IMAGE DISPLAY
     */
    /***
      USER ID IS REQUIRED
     */
   private func getUserImages(byUserID userID : String )  {
    let userInfo = self.userRef.document(userID).collection("images")
        userInfo.addSnapshotListener { (querySnapshot, err) in
            self.imageList.removeAll()
            if err != nil {
                self.completionHandler(err)
                return
            }
            for document in querySnapshot!.documents {
                let data = document.data()
                if let image = self.handelImageModel(imgObject: data) {
                    self.imageList.insert(image, at: 0)
                }
            }
            self.completionHandler(nil)
    }
    }

   private func handelImageModel(removePrivateImage:Bool = true ,imgObject: [String :Any] ) -> Image?{
        guard let json = JsonHandler.jsonToNSData(json: imgObject as [String : AnyObject]) else{return nil}
        guard let imageModel = CodableHandler.decode(Image.self, from: json) as? Image else{ return nil }
        return imageModel
    }
    
   private func insertNewImageToUser(byUserID uId : String , imgStatus : Int , url : String , userName : String){
         let img =  ["status" : imgStatus ,
                     "url" : "dssdf\(url)",
                     "userName" :userName] as [String : AnyObject]
        
        let db = Firestore.firestore()
        
        let newImageRef = db.collection("users").document(uId).collection("images").document()
        newImageRef.setData(img)
            { err in
                    if let err = err {
                        self.completionHandler(err)
                    } else {
                        self.completionHandler(nil)
                    }
                }
    }
    
}
