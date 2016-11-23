//
//  NSUserDefaults+Extension.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/23.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

private let IS_LAUNCH_APPLICATION_KEY       = "IS_LAUNCH_APPLICATION"
private let IS_USE_TRANSLATE_KEY            = "IS_USE_TRANSLATE"
private let IS_USE_LOCATION_FROM_IMAGE_KEY  = "IS_USE_LOCATION_FROM_IMAGE"
private let IS_USE_LOCATION_FROM_DEVICE_KEY = "IS_USE_LOCATION_FROM_DEVICE"

extension UserDefaults {
    var isLaunchApplication: Bool {
        get {
            return self.bool(forKey: IS_LAUNCH_APPLICATION_KEY)
        }
        set {
            self.set(newValue, forKey: IS_LAUNCH_APPLICATION_KEY)
            synchronize()
        }
    }
    
    var isUseTranstate: Bool {
        get {
            return self.bool(forKey: IS_USE_TRANSLATE_KEY)
        }
        set {
            self.set(newValue, forKey: IS_USE_TRANSLATE_KEY)
            synchronize()
        }
    }
    
    var isUseLocationFromImage: Bool {
        get {
            return self.bool(forKey: IS_USE_LOCATION_FROM_IMAGE_KEY)
        }
        set {
            self.set(newValue, forKey: IS_USE_LOCATION_FROM_IMAGE_KEY)
            synchronize()
        }
    }
    
    var isUseLocationFromDevice: Bool {
        get {
            return self.bool(forKey: IS_USE_LOCATION_FROM_DEVICE_KEY)
        }
        set {
            self.set(newValue, forKey: IS_USE_LOCATION_FROM_DEVICE_KEY)
            synchronize()
        }
    }
}
