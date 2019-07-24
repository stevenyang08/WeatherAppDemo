//
//  RoundedColoredBorderButton.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class RoundedColoredBorderUIButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 20.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.darkGray.cgColor
        clipsToBounds = true
        backgroundColor = UIColor.darkGray
        setTitleColor(UIColor.white, for: .normal)
    }

}
