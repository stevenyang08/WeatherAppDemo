//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit
import GooglePlaces

class LocationViewController: BaseViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var doneButton: RoundedColoredBorderUIButton!
    
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextfield.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonClicked(_ sender: RoundedColoredBorderUIButton) {
        if let location = location {
            StateData.instance.location = location
            StateData.instance.latitude = location.latitude
            StateData.instance.longitude = location.longitude
            StateData.instance.madeChanges = true
            dismiss(animated: true, completion: nil)
        } else {
            self.simpleAlert(title: "Error", message: "Did not select location")
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: RoundedBorderUIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func updateUI() {
        if let location = location {
            locationLabel.text = location.cityState()
        }
    }
    
    // Present the Autocomplete view controller when the button is pressed.
    private func autocompleteClicked() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.addressComponents.rawValue) |
            UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
}

extension LocationViewController: UITextFieldDelegate, GMSAutocompleteViewControllerDelegate {
    // MARK: - UITEXTFIELD DELEGATE
    func textFieldDidBeginEditing(_ textField: UITextField) {
        autocompleteClicked()
    }
    
    // MARK: - GMS DELEGATE
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let selectedLocation = Location()
        if let state = place.addressComponents?.first(where: { $0.type == "administrative_area_level_1" })?.shortName,
            let country = place.addressComponents?.first(where: { $0.type == "country" })?.shortName
        {
            selectedLocation.state = state
            selectedLocation.country = country
        }
        
        if let city = place.name {
            selectedLocation.city = city
        }
        
        selectedLocation.latitude = place.coordinate.latitude
        selectedLocation.longitude = place.coordinate.longitude
        
        location = selectedLocation
        updateUI()
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
