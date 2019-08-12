//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator()

        // Do any additional setup after loading the view.
    }
    
    private func addActivityIndicator() {
        // CAN CREATE CUSTOM OBJECT FOR THIS AS WELL
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.clipsToBounds = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.view.center
        
        self.view.addSubview(self.activityIndicator)
    }
    
    func startIndicator() {
        DispatchQueue.main.async(execute: {
            self.activityIndicator.startAnimating()
        })
    }
    
    func stopIndicator() {
        DispatchQueue.main.async(execute: {
            self.activityIndicator.stopAnimating()
        })
    }
    
    func stopRefreshing() {
        if (self.refreshControl != nil) {
            if (self.refreshControl!.isRefreshing) {
                self.refreshControl!.endRefreshing()
            }
        }
    }
    
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
