//
//  UIView+Extension.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

extension UIView {
    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
