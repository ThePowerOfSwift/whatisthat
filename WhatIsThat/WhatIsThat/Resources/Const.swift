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
        static let BackGroundGray = UIColor(hex: 0x8F8E94, alpha: 1.0)
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
        struct WeatherMap {
            static let ApiKey = "71342cab62280bfd50fff0b1a2d37dd5"
        }
    }
    struct Menu {
        struct Url {
            static let Base        = "https://whatisthat-d17d1.firebaseapp.com"
            static let Contact     = "\(Menu.Url.Base)/contact.html"
            static let Information = "\(Menu.Url.Base)/service.html"
            static let Licence     = "\(Menu.Url.Base)/licence.html"
            static let Privacy     = "\(Menu.Url.Base)/privacy.html"
            static let TermsOfUse  = "\(Menu.Url.Base)/termsOfUse.html"
        }
    }
}
