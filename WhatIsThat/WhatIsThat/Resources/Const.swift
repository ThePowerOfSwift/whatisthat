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
        static let BackGroundGray        = UIColor(hex: 0x8F8E94, alpha: 1.0)
        static let BackGroundLightGray   = UIColor(hex: 0xB9B9B9, alpha: 1.0)
        static let BackGroundAccent      = UIColor(hex: 0xFF9600, alpha: 1.0)
        static let BackGroundLightAccent = UIColor(hex: 0xFFF2DF, alpha: 1.0)
        static let MenuItemAccent        = UIColor(hex: 0xFF9600, alpha: 1.0)
        static let MenuItemBorder        = UIColor(hex: 0xFF9600, alpha: 1.0)
        static let MenuItemTitleBorder   = UIColor(hex: 0xFF9600, alpha: 1.0)
        static let MenuItemTitle         = UIColor(hex: 0x030303, alpha: 1.0)
        static let MenuItemText          = UIColor(hex: 0x8F8E94, alpha: 1.0)
    }
    struct Screen {
        static let Size = UIScreen.main.bounds.size
    }
    struct Capture {
        static let Width:  Int = 100
        static let Height: Int = 100
    }
    struct API {
        struct GoogleApiKey {
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
            static let Information = "\(Menu.Url.Base)"
            static let Licence     = "\(Menu.Url.Base)/licence.html"
            static let Privacy     = "\(Menu.Url.Base)/privacy.html"
            static let TermsOfUse  = "\(Menu.Url.Base)/termsOfUse.html"
        }
    }
}
