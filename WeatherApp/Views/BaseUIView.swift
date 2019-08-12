//
//  BaseUIView.swift
//  WeatherApp
//
//  Created by Steven on 7/24/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class BaseUIView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setBackgroundColor(hour: Int) {
        if (hour > 19 && hour < 6) {
            self.tintColor = UIColor.darkGray
        } else {
            self.tintColor = UIColor.blue
        }
    }
}
