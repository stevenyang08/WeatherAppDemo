//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
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
        
        updateUI()
        
        loadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
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
        
        collectionView.reloadData()
    }
    
    func updateUI() {
        guard currentForecast != nil else {
            return
        }
        
        dateLabel.text = currentForecast!.date.dateToWeekDate()
        
    }
    
    func loadData() {
        loadForcast()
    }
    
    func loadForcast() {
        API.instance.getForecastDaily() { (result) in
            switch (result) {
            case .success(let object):
                guard let forecasts = object as? [Forecast] else {
                    print("Unable to find objects")
                    self.forecastArray = []
                    self.collectionView.reloadData()
                    return
                }
                self.forecastArray = forecasts
                self.collectionView.reloadData()
            case .failure(let error):
                print("ERROR \(error)")
                self.forecastArray = []
                self.collectionView.reloadData()
            }
        }
        
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WeatherCollectionViewCell {
            let forecast = forecastArray[indexPath.row]
            cell.setUpCell(forecast: forecast)
            cell.imageView.image = forecast.iconDayImage
            
            return cell
        }
        
        
        return UICollectionViewCell()
    }
}
