//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

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
    
    var forecastArray: [Forecast] = []
    var currentForecast: Forecast?
    var selectedForecast: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkIfFirstLogin()
        
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
        if (stateData.latitude != 0.0 && stateData.longitude != 0.0) {
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
        let firstLaunch = UserDefaults.standard.bool(forKey: "first_launch")
        switch firstLaunch {
        case true:
            presentLocationViewController()
        case false:
            return
        }
    }
    
    private func presentLocationViewController() {
        let vc = LocationViewController()
        present(vc, animated: true, completion: nil)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

// MARK: - CollectionView

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
}
