//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: BaseViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var doneButton: RoundedColoredBorderUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonClicked(_ sender: RoundedColoredBorderUIButton) {
    }
    
    @IBAction func cancelButtonClicked(_ sender: RoundedBorderUIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func checkIfFirstLaunch() {
//        let firstLaunch = UserDefaults.standard.bool(forKey: "first_launch")
//        switch firstLaunch {
//        case true:
//
//        case false:
//            return
//        }
    }    
}

extension LocationViewController: UISearchBarDelegate {
    
}
