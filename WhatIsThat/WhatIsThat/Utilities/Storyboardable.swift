//
//  Storyboardable.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/16.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboardable {
    
    static var storyboardIdentifier: String { get }
    static var storyboardName: String { get }
}

func fromStoryboard<T: AnyObject>(clazz: T.Type) -> T! where T: Storyboardable {
    
    let identifier = T.storyboardIdentifier
    let name = T.storyboardName
    
    let storyboard = UIStoryboard(name: name, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: identifier) as? T
}
