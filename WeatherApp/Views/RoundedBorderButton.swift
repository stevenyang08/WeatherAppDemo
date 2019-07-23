//
//  RoundedBorderButton.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class RoundedBorderButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 20.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        clipsToBounds = true
    }
}
