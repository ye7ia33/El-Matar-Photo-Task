//
//  AuthenticationVC.swift
//  Photo
//
//  Created by Yahia El-Dow on 7/25/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "loginView"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        if self.inputIsValid() {
            let authVM = AuthenticationViewModel()
            guard let email = self.txtEmail.text else {return}
            guard let password = self.txtPassword.text else {return}
            
            self.showLoader()
            authVM.login(WithEmailAddress: email , password: password)
            authVM.completionHandler = {
                 err in
                if authVM.currentUser != nil {
                    self.hideLoader()
                    self.performSegue(withIdentifier: "goToTabViewController", sender: nil)
                    return
                }
                self.hideLoader()

                self.showAlert(WithMessage: "<#T##String#>")
                
            }
        }
    }
    
  
    private func inputIsValid()-> Bool{
        
        
        if  self.txtEmail.text?.isEmpty ?? true {
            self.showAlert(WithMessage: "Enter Your Email Address.")
            return false
        }
        
        if self.txtEmail.text?.isValidEmail() == false {
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
    

    

}
