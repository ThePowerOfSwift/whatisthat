//
//  Storyboardable.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/16.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Foundation
import UIKit

func fromStoryboard<T: AnyObject>(class: T.Type) -> T! {
    let identifier = String(describing: T.self)
    let name = String(describing: T.self)
    let storyboard = UIStoryboard(name: name, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: identifier) as? T
}
