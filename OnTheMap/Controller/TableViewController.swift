//
//  TableViewController.swift
//  OnTheMap
//
//  Created by imac on 7/19/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import UIKit

class TableViewController: MainViewController {

    @IBOutlet weak var tableView: UITableView!
    

    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 70
        
        OTMClient.getStudentsLocation() { locations, error in
            LocationModel.studentsLocationList = locations.results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationModel.studentsLocationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath as IndexPath)
        
        let location = LocationModel.studentsLocationList[indexPath.row]
        
        cell.textLabel?.text = "\(location.firstName!) \(location.lastName!)"
        cell.imageView?.image = UIImage(named: "icon_pin")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let location = LocationModel.studentsLocationList[indexPath.row]
        let app = UIApplication.shared
         let studentUrl = location.mediaURL
       
        let url = URL(string: studentUrl!)
        
        if url != nil {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
