//
//  LoadingView.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/03.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = CGRect(x: 0, y: 0, width: Const.Screen.Size.width, height: Const.Screen.Size.height)
    }
    
    func show() {
        if let window :UIWindow = UIApplication.shared.keyWindow {
            window.addSubview(self)
        }
    }
    
    func hide() {
        self.removeFromSuperview()
    }
}
