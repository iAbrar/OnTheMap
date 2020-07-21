//
//  PostLocationViewController.swift
//  OnTheMap
//
//  Created by imac on 7/20/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit
import MapKit

class PostLocationViewController: UIViewController, MKMapViewDelegate {

    var location = StudentLocation()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       mapView.delegate = self
        
       self.location.firstName = UserInfoModel.user.firstName
        //create annotation
        let annotation = MKPointAnnotation()
        annotation.title = location.mapString
        annotation.coordinate = CLLocationCoordinate2DMake(location.latitude!, location.longitude!)
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
        mapView.addAnnotation(annotation)
        //zooming in the annotation
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude!, location.longitude!)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
       
    }
    
    @IBAction func finishTapped(_ sender: Any) {
       
        OTMClient.postUserLocation(student: self.location) { (error) in
           
            guard error == nil else {
                print(error)
                return
            }
            DispatchQueue.main.async {
                
                let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
                if let navigator = self.navigationController {
                    navigator.pushViewController(tabBarController, animated: true)
                }
            }
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
