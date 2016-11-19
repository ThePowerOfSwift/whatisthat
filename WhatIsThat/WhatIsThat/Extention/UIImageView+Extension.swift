//
//  UIImageView+Extension.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/19.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

extension UIImageView {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)
    }
}
