//
//  BorderTableViewDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/19.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class BorderTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = []
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Const.Screen.Size.width, height: 20))
        headerView.backgroundColor = Const.Color.BackGroundGray
        return headerView
    }
}
