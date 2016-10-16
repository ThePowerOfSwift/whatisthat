//
//  Xibable.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/16.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Foundation
import UIKit

protocol Xibable {
    
    static var xibName: String { get }
}

func fromXib<T: AnyObject>(clazz: T.Type, owner: AnyObject? = nil, options: [NSObject: AnyObject]? = nil, atIndex index: Int = 0) -> T! where T: Xibable {
    
    let name = T.xibName
    
    let xib = UINib(nibName: name, bundle: nil)
    return xib.instantiate(withOwner: owner, options: options)[index] as? T
}
