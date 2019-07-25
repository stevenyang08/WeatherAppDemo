//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class WeatherDetailViewController: BaseViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDetailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    
    var forecast: Forecast?

    override func viewDidLoad() {
        super.viewDidLoad()
        LogManager.instance.Log.debug("Loaded", self)

        updateUI()
        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
        if let forecast = forecast {
            dateLabel.text = forecast.date.dateToWeekDate()
            weatherLabel.text = forecast.weather
            weatherDetailLabel.text = forecast.summary
            imageView.image = forecast.iconImage
            tempHighLabel.text = forecast.temperatureString(temperatureType: .TemperatureHigh)
            tempLowLabel.text = forecast.temperatureString(temperatureType: .TemperatureLow)
            humidityLabel.text = forecast.humidity
            windSpeedLabel.text = forecast.windSpeed
            currentTempLabel.text = forecast.temperatureString(temperatureType: .Temperature)
            feelsLikeTempLabel.text = forecast.temperatureString(temperatureType: .ApparentTemperature)
        }
    }
}
