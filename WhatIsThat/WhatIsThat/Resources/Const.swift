//
//  Const.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/16.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Foundation
import UIKit

struct Const {
    struct Color {
        static let CorporateLogo = UIColor.black
        static let HelpButtonBackground = UIColor.white
    }
    struct Screen {
        static let Size = UIScreen.main.bounds.size
    }
    struct Capture {
        static let Width:  Int = 100
        static let Height: Int = 100
    }
    struct API {
        struct CloudVision {
            static let ApiKey = "AIzaSyA04hrp5OA2WcgmXfs6PE6smno018Cmg6A"
        }
    }
}
