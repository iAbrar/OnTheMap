//
//  MapViewController.swift
//  OnTheMap
//
//  Created by imac on 7/19/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: MainViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var studentsLocations: Locations?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        OTMClient.getStudentsLocation() { locations, error in
            self.studentsLocations = locations
            
            guard let test = self.studentsLocations
                else{
                    return
            }
            self.createAnnotations(locations: test.results)
          
            
        }
    }
    
    func createAnnotations(locations: [StudentLocation]){
        for location in locations {
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(location.firstName) \(location.lastName)"
            annotation.subtitle = location.mediaURL
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let studentUrl = view.annotation?.subtitle!,
                let url = URL(string: studentUrl), app.canOpenURL(url) {
                app.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pin = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pin) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pin)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
}
