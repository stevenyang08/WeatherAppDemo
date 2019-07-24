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
    
    var selectedForecast: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkIfFirstLogin()
        updateUI()
        
        loadForcast()

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
            print("Fahrenheit")
            StateData.instance.isMetric = false
            PersistenceManager.save(false as AnyObject, path: .IsMetric)
        case 1:
            print("Celsius")
            StateData.instance.isMetric = true
            PersistenceManager.save(true as AnyObject, path: .IsMetric)
        default:
            return
        }
    }
    
    func updateUI() {
        if StateData.instance.isMetric {
            tempSegmentedControl.selectedSegmentIndex = 1
        } else {
            tempSegmentedControl.selectedSegmentIndex = 2
        }
    }
    
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
    
    func loadForcast() {
        API.instance.getForecastDaily() { (result) in
            switch (result) {
            case .success(_):
                print("Success")
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
