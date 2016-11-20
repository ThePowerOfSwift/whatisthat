//
//  SimpleImageView.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import Spring

class SimpleImageView: UIView {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var safeRateLabel: UILabel!
    @IBOutlet weak var weatherButton: SpringButton!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    var mainImage: UIImage? {
        didSet {
            mainImageView.image = mainImage
        }
    }
    
    var safeRate: Int = 0 {
        didSet {
            safeRateLabel.text = "\(safeRate)%"
        }
    }
    
    var adultRate: Int = 0 {
        didSet {
            if adultRate < SafeSearchLikelyHood.UNKNOWN.toScore() {
                mainImageView.addBlurEffect()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        closeButton.layer.shadowColor = UIColor.white.cgColor
        NotificationCenter.default.addObserver(self, selector: #selector(showWeatherIcon), name: Notification.Name(rawValue:"showWeatherIcon"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        UIApplication.shared.topViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedWeatherButton(_ sender: UIButton) {
        guard let vc = fromStoryboard(class: WeatherViewController.self) else { return }
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        vc.tappedImage = mainImage
        UIApplication.shared.topViewController?.present(vc, animated: true, completion: nil)
    }
    
    func showWeatherIcon() {
        weatherButton.isHidden  = false
        weatherButton.animation = "pop"
        weatherButton.force = 1.5
        weatherButton.duration = 0.5
        weatherButton.animate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.weatherImageView.image = WeatherMapManager.getWeatherIcon()
        }
    }
}
