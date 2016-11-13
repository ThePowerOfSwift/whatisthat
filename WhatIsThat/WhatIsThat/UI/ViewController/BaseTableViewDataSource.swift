
//
//  BaseDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/09.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

protocol BaseTableViewDataSource: UITableViewDelegate, UITableViewDataSource {
    var viewClasses: [UITableViewCell.Type]? { get set }
}
