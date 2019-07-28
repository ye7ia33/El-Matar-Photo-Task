//
//  AuthenticationViewModel.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/26/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthenticationViewModel: ViewModel {
    
    lazy var currentUser = Auth.auth().currentUser
    
    func login(WithEmailAddress email : String , password : String){
        if email.isEmpty || password.isEmpty {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (auth, err) in
            if auth != nil {
                self.currentUser = auth?.user
            }else{
                self.currentUser = nil
            }
            
            self.completionHandler(err)
        }
        
    }
    
    func registration(whithUserName userName: String, email: String, password: String )  {
      
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if err != nil{
                self.currentUser = nil
                self.completionHandler(err)
                return
            }
            if auth != nil, let user  = auth?.user  {
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = userName
                changeRequest.commitChanges(completion: { (err) in
                    self.currentUser = auth?.user
                    self.completionHandler(err)
                    return
                })
                
            }
        
        
        }
        
        
        
    }
    
    func logout()  {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            
        }catch let err as NSError { 
            print(err)
        }
    self.completionHandler(nil)
    }
    
    
    
    func resetPassword (withEmail email: String )  {
        Auth.auth().sendPasswordReset(withEmail: email) { (err) in
            self.completionHandler(err)
        }

    }
    
    
}
