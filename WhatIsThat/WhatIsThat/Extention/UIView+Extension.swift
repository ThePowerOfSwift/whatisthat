//
//  UIView+Extension.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

extension UIView {
    enum BorderPosition {
        case Top
        case Right
        case Bottom
        case Left
    }
    
    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func border(positions: [BorderPosition], borderWidth: CGFloat, borderColor: UIColor?) {
        guard let borderColor = borderColor else { return }
        
        if positions.contains(.Top) {
            let topLine = CALayer()
            topLine.backgroundColor = borderColor.cgColor
            topLine.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: borderWidth)
            self.layer.addSublayer(topLine)
        }
        if positions.contains(.Left) {
            let leftLine = CALayer()
            leftLine.backgroundColor = borderColor.cgColor
            leftLine.frame = CGRect(x: 0.0, y: 0.0, width: borderWidth, height: self.frame.height)
            self.layer.addSublayer(leftLine)
        }
        if positions.contains(.Bottom) {
            let bottomLine = CALayer()
            bottomLine.backgroundColor = borderColor.cgColor
            bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth)
            self.layer.addSublayer(bottomLine)
        }
        if positions.contains(.Right) {
            let rightLine = CALayer()
            rightLine.backgroundColor = borderColor.cgColor
            rightLine.frame = CGRect(x: self.frame.width - borderWidth, y: 0.0, width: borderWidth, height: self.frame.height)
            self.layer.addSublayer(rightLine)
        }
    }
}
