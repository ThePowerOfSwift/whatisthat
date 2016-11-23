//
//  MigrationManager.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/23.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class MigrationManager: NSObject {
    static func initialSettings() {
        guard UserDefaults.standard.isLaunchApplication == false else { return }
        UserDefaults.standard.isLaunchApplication     = true
        UserDefaults.standard.isUseAutoTranstate      = false
        UserDefaults.standard.isUseLocationFromImage  = false
        UserDefaults.standard.isUseLocationFromDevice = true
    }
}
