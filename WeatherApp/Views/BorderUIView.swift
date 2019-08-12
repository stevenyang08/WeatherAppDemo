//
//  BorderUIView.swift
//  WeatherApp
//
//  Created by Steven on 7/24/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class BorderUIView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 2.0
        layer.cornerRadius = 10.0
        clipsToBounds = true

        layer.borderColor = UIColor.white.cgColor

//        
//        if StateData.instance.isNight {
//            layer.borderColor = UIColor.white.cgColor
//        } else {
//            layer.borderColor = UIColor.black.cgColor
//        }
    }

}
