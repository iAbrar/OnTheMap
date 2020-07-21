//
//  UIViewController.swift
//  OnTheMap
//
//  Created by imac on 7/21/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorMSg(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
