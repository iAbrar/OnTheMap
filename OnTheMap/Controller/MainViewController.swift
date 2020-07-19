//
//  StudentsLocationViewController.swift
//  OnTheMap
//
//  Created by imac on 7/18/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    
    override func viewDidLoad() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addLocationTapped(_:)))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshLocationsTapped(_:)))
        let logoutButton = UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(self.logoutTapped(_:)))
        
        navigationItem.rightBarButtonItems = [addButton, refreshButton]
        navigationItem.leftBarButtonItem = logoutButton
        
    }
    
    @objc func addLocationTapped(_ sender: Any){
        print("addLocationTapped")
    }
    
    @objc func refreshLocationsTapped(_ sender: Any){
        print("refreshLocationsTapped")
    }
    
    @objc func logoutTapped(_ sender: Any){
        print("logoutTapped")
    }
}
