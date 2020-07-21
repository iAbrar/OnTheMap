//
//  NewLocationViewController.swift
//  OnTheMap
//
//  Created by imac on 7/20/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit
import MapKit

class NewLocationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var mediaLink: UITextField!
    
     let activity = UIActivityIndicatorView(style: .gray)
    
    var studentLocation = StudentLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.delegate = self
        mediaLink.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add Location", style: .done, target: self, action: #selector(self.cancelTapped(_:)))
    }
    
    @IBAction func findLocationTapped(_ sender: UIButton) {
        guard let location = location.text,
            let mediaLink = mediaLink.text,
            location != "", mediaLink != "" else {
                self.showErrorMSg(title: "Place not found", message: "Please fill both fields and try again")
                return
        }
        
        
        self.studentLocation.mapString = location
        self.studentLocation.mediaURL = mediaLink
        
       
        self.view.addSubview(activity)
        self.view.bringSubviewToFront(activity)
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        activity.startAnimating()
        // create the search request
        
        let search = MKLocalSearch.Request()
        search.naturalLanguageQuery = location
        
        let activeSearch = MKLocalSearch(request: search)
        activeSearch.start {(response, error) in
            
            if response == nil {
                self.showErrorMSg(title: "Place not found", message: "Please try again! ")
                self.activity.stopAnimating()
                return
            }else{
                
                // getting the data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                self.studentLocation.latitude = latitude
                self.studentLocation.longitude = longitude
                
                
                // send student location to post location vc
                self.performSegue(withIdentifier: "newLocationMap", sender: self.studentLocation)
                 self.activity.stopAnimating()
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PostLocationViewController
        vc.location = self.studentLocation
    }
    
    @objc func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
