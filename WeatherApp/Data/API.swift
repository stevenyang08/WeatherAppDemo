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
 API: https://developer.accuweather.com/
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
    let params: [String: Any] = [
        "apikey": ConfigurationManager.instance.getAPIKey()
    ]
    
    func getForcastDaily(completion: @escaping (GetResult) -> ()) {
        if let url = getURL(urlKey: .GETFORECASTDAYS,  StateData.instance.staticLocationKey) {
            
            Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.queryString).responseJSON { (response) in
                
                guard response.result.error == nil else {
                    return completion(.failure(response.result.error!))
                }
                
                guard let json = response.result.value as? Dictionary<String, Any> else {
                    print("Unexpected result value")
                    return completion(.failure(APIError.invalidJSONData))
                }
                
                guard let jsonArray = json["DailyForecasts"] as? [Dictionary<String, Any>] else {
                    print("Unexpected result value")
                    return completion(.failure(APIError.invalidJSONData))
                }
                
//                var forecastArray = [Forecast]()
//
//                for object in jsonArray {
//                    let forecast = Forecast(dict: object)
//                    forecastArray.append(forecast)
//                }
                
                return completion(.success(""))
            }
        } else {
            return completion(.failure(APIError.invalidURL))
        }
    }
    
    func getCities(string: String, completion: @escaping (GetResult) -> ()) {
        if let url = getURL(urlKey: .GETCITY) {
            var parameters: [String: Any] = params
            parameters["q"] = string
            
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString).responseJSON { (response) in
                
                guard response.result.error == nil else {
                    return completion(.failure(response.result.error!))
                }
                
//                print(response.result.value)
                
                guard let jsonArray = response.result.value as? [Dictionary<String, Any>] else {
                    print("Unexpected result value")
                    return completion(.failure(APIError.invalidJSONData))
                }
                
                print(jsonArray)
//
//                var locationArray = [Location]()
//
//                for object in jsonArray {
//                    let location = Location(dict: object)
//                    locationArray.append(location)
//                }
                
                return completion(.success(""))
            }
        }else {
            return completion(.failure(APIError.invalidURL))
        }
    }
    
    fileprivate func getURL(urlKey: URLKey, _ locationKey: String? = nil) -> URL? {
        let urlString = configurationManager.urlForPath(urlKey: urlKey)
        guard locationKey != nil else {
            print(urlString)
            return URL(string: urlString) ?? nil
        }
        
        let componentString = urlString.replacingOccurrences(of: "{locationKey}", with: locationKey!)
        
        print(componentString)
        return URL(string: componentString) ?? nil
    }
}
