//
//  ViewController.swift
//  OnTheMap
//
//  Created by imac on 7/14/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    
    @IBAction func signUpTapped(_ sender: UIButton) {
       
            if let url = URL(string: "https://auth.udacity.com/sign-up"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
    }
  
}

