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
              print("error")
                return
        }
        
        
        self.studentLocation.mapString = location
        self.studentLocation.mediaURL = mediaLink
        
        // create the search request
        
        let search = MKLocalSearch.Request()
        search.naturalLanguageQuery = location
        
        let activeSearch = MKLocalSearch(request: search)
        activeSearch.start {(response, error) in
            
            if response == nil {
                print("Location not found!")
            }else{
                
                // getting the data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                self.studentLocation.latitude = latitude
                self.studentLocation.longitude = longitude
               
                
                // send student location to post location vc
                self.performSegue(withIdentifier: "newLocationMap", sender: self.studentLocation)
    
            }
            
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! PostLocationViewController
        vc.location = self.studentLocation
    }
    
    @objc func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
