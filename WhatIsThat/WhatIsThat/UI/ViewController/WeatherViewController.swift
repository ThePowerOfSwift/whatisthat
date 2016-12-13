//
//  WeatherViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/18.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
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
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set view settings
        mainImageView.image = tappedImage
        closeButton.layer.shadowColor = UIColor.white.cgColor
        
        // Set map location data
        showMap()
        
        // Show weather information
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
    
    func showMap() {
        guard let latitude = latitude else { return }
        guard let longitude = longitude else { return }
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.setCenter(location, animated: true)
        var region = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.2
        region.span.longitudeDelta = 0.2
        mapView.setRegion(region, animated: true)
        mapView.mapType = MKMapType.standard
    }
}
