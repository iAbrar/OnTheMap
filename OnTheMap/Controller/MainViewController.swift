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
//, MKMapViewDelegate {

//    var test: Locations?
    
//    @IBOutlet weak var mapView: MKMapView!
//
//    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
//        mapView.delegate = self

        
//        loadStudentsLocation()

        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
////        tableView.reloadData()
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
//    func loadStudentsLocation (){
//        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?limit=100")!)
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { data, response, error in
//
//            if error != nil { // Handle error...
//                return
//            }
//
//            do{
//
//                let locations = try JSONDecoder().decode(Locations.self, from: data!)
//                self.test = locations.results
//                print(self.test.count)
//                self.createAnnotations(locations: locations.results)
//
//            }catch{
//                print(error)
//            }
//
//        }
//        task.resume()
//        OTMClient.getStudentsLocation() { locations, error in
//            self.test = locations
//            print("loadStudentsLocation \(String(describing: self.test?.results.count))")
//        }
//    }
    
//    func createAnnotations(locations: [StudentLocation]){
//        for location in locations {
//
//            let annotation = MKPointAnnotation()
//            annotation.title = "\(location.firstName) \(location.lastName)"
//            annotation.subtitle = location.mediaURL
//            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//            mapView.addAnnotation(annotation)
//        }
//    }
//
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        if control == view.rightCalloutAccessoryView {
//            let app = UIApplication.shared
//            if let studentUrl = view.annotation?.subtitle!,
//                let url = URL(string: studentUrl), app.canOpenURL(url) {
//                app.open(url, options: [:], completionHandler: nil)
//            }
//        }
//    }
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        let pin = "pin"
//
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pin) as? MKPinAnnotationView
//
//        if pinView == nil {
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pin)
//            pinView!.canShowCallout = true
//            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        else {
//            pinView!.annotation = annotation
//        }
//
//        return pinView
//    }
//  
//}

//extension MainViewController: UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.test.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
//        cell.textLabel?.text = self.test[indexPath.row].firstName
//        return cell
//    }
    
}
