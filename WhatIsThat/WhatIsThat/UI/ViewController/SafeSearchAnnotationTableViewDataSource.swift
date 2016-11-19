//
//  SafeSearchAnnotationTableViewDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class SafeSearchAnnotationTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [SafeSearchAnnotationTableViewCell.self]
    let result = RealmManager.get(CloudVisions.self, key: 0)?.responses.first?.safeSearchAnnotation
    var delegate: UIViewController?
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(className: SafeSearchAnnotationTableViewCell.self, indexPath: indexPath)
        if let adult = result?.adult {
            cell.adult = adult
        }
        if let medical = result?.medical {
            cell.medical = medical
        }
        if let spoof = result?.spoof {
            cell.spoof = spoof
        }
        if let violence = result?.violence {
            cell.violence = violence
        }
        cell.setContent()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = fromXib(class: SimpleTitleView.self)
        headerView?.titleLabel.text = "有害コンテンツチェック"
        return headerView
    }
}
