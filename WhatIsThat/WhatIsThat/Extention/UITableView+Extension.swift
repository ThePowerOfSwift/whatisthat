
//
//  UITableView+Extension.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/07.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(className: T.Type) {
        register(UINib(nibName: String(describing: className), bundle: nil), forCellReuseIdentifier: String(describing: className))
    }
    
    func register<T: UITableViewCell>(classNames: [T.Type]) {
        classNames.forEach { register(className: $0) }
    }
    
    func dequeueCell<T: UITableViewCell>(className: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: className), for: indexPath) as! T
    }
}
