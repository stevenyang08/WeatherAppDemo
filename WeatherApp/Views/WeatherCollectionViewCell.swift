//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var view: BorderUIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var currentForecast: Forecast?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setUpCell(forecast: Forecast) {
        currentForecast = forecast
        dateLabel.text = forecast.date.dateToWeekDay()
        weatherLabel.text = forecast.weather
        currentTempLabel.text = forecast.temperatureString(temperatureType: .Temperature)
        highTempLabel.text = forecast.temperatureString(temperatureType: .TemperatureHigh)
        lowTempLabel.text = forecast.temperatureString(temperatureType: .TemperatureLow)
    }
}
