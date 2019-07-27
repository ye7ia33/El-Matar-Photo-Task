//
//  RegistrationVC.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }


    @IBAction func registrationButtonAction(_ sender: Any) {
            if self.inputIsValid() {
                let auth = AuthenticationViewModel()
                guard let name = self.txtName.text else {return}
                guard let email = self.txtEmail.text else {return}
                guard let password = self.txtPassword.text else {return}
                self.showLoader()
                auth.registration(whithUserName: name , email: email, password: password)
                auth.completionHandler = {
                    err in
                    if err != nil {
                        self.performSegue(withIdentifier: "goToTabViewController", sender: nil)
                    }else{
                        self.showAlert(WithMessage: err?.localizedDescription ?? "Error.")
                    }
                   self.hideLoader()

                }
               
            }
    }
    
    
    
    private func inputIsValid()-> Bool{
      
        if self.txtName.text?.isEmpty ?? false {
            self.showAlert(WithMessage: "Enter User Name.")
            return false
        }
        
        let email = self.txtEmail.text ?? ""
        
        if email.isEmpty {
            self.showAlert(WithMessage: "Enter Your Email Address.")
            return false
        }
        
        if email.isValidEmail() == false {
            self.showAlert(WithMessage: "Insert Right Email Format.")
            
            return false
        }
        if self.txtPassword.text?.isEmpty ?? false {
            self.showAlert(WithMessage: "Enter Password.")
            return false
        }
        if self.txtPassword.text?.count ?? 0 < 6 {
            self.showAlert(WithMessage: "Password is minimum 6 digits")
            return false
        }
        
        
        return true
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
