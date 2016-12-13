//
//  GlobalFunctions.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/21.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

func print(_ items: Any..., separator: String = "", terminator: String = "") {
    #if DEBUG
        Swift.print(items, separator: separator, terminator: terminator)
    #endif
}
