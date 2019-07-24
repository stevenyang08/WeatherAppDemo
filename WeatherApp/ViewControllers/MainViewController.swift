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
    
    var selectedForecast: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkIfFirstLogin()
        
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
        case 1:
            print("Fahrenheit")
        case 2:
            print("Celsius")
        default:
            return
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
