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
    
    var imageList: Array = Array<Image>()
    
    private let userRef = Firestore.firestore().collection("users")
    
    /*** GET IMAGE DEPINCE ON ImagePrivacy TYPE {PUBLIC / PRIVATE}
     * IF NEED USER IMAGE PROFILE PASS  userImage AS ImagePrivacy TYPE
     * public JUST RETIRIVE ONLY PUBLIC USER IMAGE
     * @param privacy = ImagePrivacy, userId = User.id
     *      //Call Method
            getImages(privacy: .userImage ,byUserId: UserViewModel.shared.user.id)
     */

    func getImages(privacy: ImagePrivacy , byUserId userId : String? = nil){
       
        if privacy == .privateImage {
            if userId == nil || userId?.isEmpty ?? true{
               fatalError("IF privacy is equal private userID is required")
            }
               self.getUserImages(byUserID:userId!)
                return
            }

           
        
        self.getPublicImages()
    }
    
    func uploadImage(ByUserId uId : String , image : Image){
        guard let imageData = image.imageData else{return}
        
        let storageRef = Storage.storage().reference(withPath: "usersImages")

        let imgName =  "\(uId)_\(arc4random())"
        let imagesRef = storageRef.child("\(imgName).jpeg")
        
        imagesRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                self.completionHandler(error)
                return
            }
            if let imgName = metadata.name {
                let imgUrl = "\(IMAGE_URL)\(imgName)?alt=media"
                self.insertNewImageToUser(byUserID: uId, imgStatus: image.imgaeStatus ?? 0, url: imgUrl, userName: image.userName ?? "")
            }else{
                self.completionHandler(nil)
            }
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
        self.imageList.removeAll()

            if let err = err {
                self.completionHandler(err)
            } else {

                for document in querySnapshot!.documents {
                    
                    self.userRef.document(document.documentID)
                        .collection("images")
                        .whereField("status", isEqualTo: 1)
                        .getDocuments(completion: {(querySnapshot, err) in
                            if err != nil {
                                self.completionHandler(err)
                                return
                        }
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            if let image = self.handelImageModel(imgObject: data) {
                           let isContains =  self.imageList.contains(where: { (img) -> Bool in
                                if img.imgUrl == image.imgUrl {return true}
                                return false
                                })
                           
                                isContains == false ? self.imageList.append(image) : nil
                              
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
                    self.imageList.append(image)
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
                     "url" : "\(url)",
                     "userName" :userName] as [String : AnyObject]
      userRef.document(uId).setData(["lastUpdate" : Date()])
       userRef.document(uId).collection("images").addDocument(data: img, completion: { (err) in
                    if let err = err {
                        self.completionHandler(err)
                    } else {
                        self.completionHandler(nil)
                    }
        
        })
    }
    
    
}
