//
//  MainViewControllerTest.swift
//  WeatherAppTests
//
//  Created by Steven on 8/9/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import XCTest
@testable import WeatherApp

class MainViewControllerTest: XCTestCase {
    
    var vc: MainViewController!
    let api = API.instance
    let stateData = StateData.instance


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        vc = MainViewController()
//        vc.viewDidLoad()
    }
    
    override func tearDown() {
//        vc = nil
        super.tearDown()
    }
    
    func testDailyForecastAPI() {
        let expection = self.expectation(description: "Daily Forecast API Expectation")
        var forecasts: [Forecast] = []
        api.getForecastDaily(latitude: 44.2231, longitude: 95.4697) { (result) in
            switch (result) {
            case .success(let object):
                LogManager.instance.Log.trace("SUCCESS")
                guard let forecastArray = object as? [Forecast] else {
                    XCTFail()
                    return
                }
                forecasts = forecastArray
                expection.fulfill()
            case .failure(let err):
                XCTFail(err.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 10.0) { (error) in
            print(forecasts.count)
        }
    }
}
