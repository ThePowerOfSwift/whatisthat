//
//  WeatherViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/18.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!

    var tappedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set main image
        mainImageView.image = tappedImage
        
        // Show Weather Information
        showWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func showWeather() {
        contentView.isHidden = false
        guard let result   = RealmManager.get(WeatherMap.self, key: 0) else { return }
        guard let temp     = result.list.first?.temp    else { return }
        guard let humidity = result.list.first?.humidity else { return }
        guard let pressure = result.list.first?.pressure else { return }
        guard let weather = result.list.first?.weather.first?.note else { return }
        guard let windSpeed = result.list.first?.windSpeed else { return }
        
        print("weather=\(weather)")
        weatherImageView.image = WeatherMapManager.getWeatherIcon()
        locationLabel.text = result.name
        dateLabel.text = Date().toString(format: "yyyy年MM月dd日(EEE)")
        temperatureLabel.text = "\(String(format: "%.01f", (CGFloat(temp) - 273.15)))℃"
        humidityLabel.text    = "\(humidity)%"
        windSpeedLabel.text   = "\(windSpeed)m/s"
        pressureLabel.text    = "\(pressure)hpa"
    }
}
