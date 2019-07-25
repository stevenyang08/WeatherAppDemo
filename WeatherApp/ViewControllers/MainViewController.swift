//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var tempSegmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    var forecastArray: [Forecast] = []
    var currentForecast: Forecast?
    var selectedForecast: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        // Intial Set Up
        if StateData.instance.isMetric {
            tempSegmentedControl.selectedSegmentIndex = 1
        } else {
            tempSegmentedControl.selectedSegmentIndex = 2
        }
        
        // Adds Refresh
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        scrollView.addSubview(refreshControl!)
        
        checkIfFirstLogin()
        
        // Loads API Data
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if StateData.instance.madeChanges == true {
            loadData()
            StateData.instance.madeChanges = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Ibactions
    
    @IBAction func changeCityButtonClicked(_ sender: Any) {
        presentLocationViewController()
    }
    
    @IBAction func detailButtonClicked(_ sender: Any) {
        if let forecast = currentForecast {
            selectedForecast = forecast
            self.performSegue(withIdentifier: "toDetailVC", sender: nil)
        }
    }
    
    @IBAction func temperatureSegmentControlClicked(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            StateData.instance.isMetric = false
            PersistenceManager.save(false as AnyObject, path: .IsMetric)
        case 1:
            StateData.instance.isMetric = true
            PersistenceManager.save(true as AnyObject, path: .IsMetric)
        default:
            return
        }
        
        updateUI()
        reloadData()
    }
    
    // MARK: - Functions
    
    @objc func refresh(_ sender: AnyObject) {
        loadData()
    }
    
    func updateUI() {
        if let current = currentForecast {
            locationLabel.text = StateData.instance.location.cityState()
            dateLabel.text = current.date.dateToWeekDate()
            weatherImageView.image = current.iconImage
            currentTemperatureLabel.text = current.temperatureString(temperatureType: .Temperature)
            highTempLabel.text = current.temperatureString(temperatureType: .TemperatureHigh)
            lowTempLabel.text = current.temperatureString(temperatureType: .TemperatureLow)
        } else {
            dateLabel.text = Date().dateToWeekDate()
        }
    }
    
    func loadData() {
        let stateData = StateData.instance
        if (stateData.location.latitude != 0.0 && stateData.location.longitude != 0.0) {
            self.startIndicator()
            API.instance.getForecastDaily() { (result) in
                switch (result) {
                case .success(let object):
                    print("SUCCESS")
                    guard let forecasts = object as? [Forecast], let current = forecasts.first else {
                        print("Unable to find objects")
                        self.forecastArray = []
                        self.reloadData()
                        return
                    }
                    var array = forecasts
                    array.removeFirst()
                    self.forecastArray = array
                    self.currentForecast = current
                    self.updateUI()
                    self.reloadData()
                case .failure(let error):
                    print("ERROR \(error)")
                    self.forecastArray = []
                    self.reloadData()
                }
            }
        }
    }
    
    func reloadData() {
        if (self.activityIndicator.isAnimating) {
            self.stopIndicator()
        }
        
        stopRefreshing()
        collectionView.reloadData()
    }
    
    // Login Check
    func checkIfFirstLogin() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "first_launch")
        switch launchedBefore {
        case true:
            return
        case false:
            checkCurrentLocation()
        }
    }
    
    fileprivate func checkCurrentLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            return
        }
    }
    
    private func presentLocationViewController() {
        let vc = LocationViewController()
        present(vc, animated: true, completion: nil)
    }
    
    fileprivate func getLocation(latitude: Double, longitude: Double) {
        let clLocation = CLLocation(latitude: latitude, longitude: longitude)
        AppDelegate.geoCoder.reverseGeocodeLocation(clLocation) { (placemarks, err) in
            if let place = placemarks?.first, let city = place.locality, let country = place.isoCountryCode {

                StateData.instance.location.city = city
                StateData.instance.location.country = country
                
                if let state = place.administrativeArea {
                    StateData.instance.location.state = state
                }
                
                self.loadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WeatherDetailViewController {
            destination.forecast = selectedForecast
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

// MARK: - CollectionView

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WeatherCollectionViewCell {
            let forecast = forecastArray[indexPath.row]
            cell.setUpCell(forecast: forecast)
            cell.imageView.image = forecast.iconImage
            
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let forecast = forecastArray[indexPath.row]
        selectedForecast = forecast
        performSegue(withIdentifier: "toDetailVC", sender: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            if let location = manager.location {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                StateData.instance.location.latitude = latitude
                StateData.instance.location.longitude = longitude
                getLocation(latitude: latitude, longitude: longitude)
                UserDefaults.standard.setValue(true, forKey: "first_launch")
            }
        }
    }
}
