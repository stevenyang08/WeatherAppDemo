//
//  API.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit
import Alamofire

/*
 API: https://darksky.net/ AKA forecast.io
*/

enum APIError: Error {
    case invalidURL
    case invalidJSONData
    case requestUnavailable
}

enum GetResult {
    case success(Any)
    case failure(Error)
}

class API {
    static let instance = API()
    private init() {}
    
    let configurationManager = ConfigurationManager.instance
    let apikey = ConfigurationManager.instance.urlForPath(urlKey: .APIKEY)
    let googleAPIKey = ConfigurationManager.instance.urlForPath(urlKey: .GOOGLEAPIKEY)
    
    // GET FORECAST
    func getForecastDaily(completion: @escaping (GetResult) -> ()) {
        let stateData = StateData.instance
        if let url = getURL(urlKey: .GETFORECAST, latitude: stateData.location.latitude, longitude: stateData.location.longitude) {
            
            Alamofire.request(url).responseJSON { (response) in
                guard response.result.error == nil else {
                    return completion(.failure(response.result.error!))
                }
                
                guard let json = response.result.value as? Dictionary<String, Any> else {
                    LogManager.instance.Log.warning("Unexpected result value")
                    return completion(.failure(APIError.invalidJSONData))
                }
                
                // CURRENT FORECAST
                guard let currentDict = json["currently"] as? Dictionary<String, Any> else {
                    LogManager.instance.Log.warning("Unexpected result value")
                    return completion(.failure(APIError.invalidJSONData))
                }
                
                // DAILY FORECASTS
                guard let dailyJson = json["daily"] as? Dictionary<String, Any> , let jsonArray = dailyJson["data"] as? [Dictionary<String, Any>] else {
                    LogManager.instance.Log.warning("Unexpected result value")
                    return completion(.failure(APIError.invalidJSONData))
                }
                
                var forecastArray = [Forecast]()

                for i in 0..<jsonArray.count {
                    let dict = jsonArray[i]
                    var forecast: Forecast!
                    if i == 0 {
                        // ADDS CURRENT TEMP TO CURRENT FORECAST
                        forecast = Forecast(dict: dict, currentDict)
                    } else {
                        forecast = Forecast(dict: dict)
                    }
                    forecastArray.append(forecast)
                }
                
                return completion(.success(forecastArray))
            }
        } else {
            return completion(.failure(APIError.invalidURL))
        }
    }
    
    private func getURL(urlKey: URLKey, latitude: Double?, longitude: Double?) -> URL? {
        let urlString = configurationManager.urlForPath(urlKey: urlKey).replacingOccurrences(of: "{apikey}", with: apikey)
        
        guard latitude != nil && longitude != nil else {
            return URL(string: urlString) ?? nil
        }
        let latLongString = "\(latitude!),\(longitude!)"
        let componentString = urlString.replacingOccurrences(of: "{latlong}", with: latLongString)
        return URL(string: componentString) ?? nil
    }
}
