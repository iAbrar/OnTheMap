//
//  ViewController.swift
//  OnTheMap
//
//  Created by imac on 7/14/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    
    @IBAction func signUpTapped(_ sender: UIButton) {
       
            if let url = URL(string: "https://auth.udacity.com/sign-up"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
    }
    
    @IBAction func logInTapped(_ sender: UIButton) {
        OTMClient.login(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            
            guard error == nil else {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "Login", sender: nil)
            }
        }
    }
    
}
