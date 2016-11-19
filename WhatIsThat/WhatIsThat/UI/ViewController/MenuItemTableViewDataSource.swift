//
//  MenuItemTableViewDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/18.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class MenuItemTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [MenuItemTableViewCell.self]
    var menuItems = [[String: Any]]()
    var delegate: UIViewController?
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(className: MenuItemTableViewCell.self, indexPath: indexPath)
        if let title = menuItems[indexPath.row]["title"] as? String {
            cell.title = title
        }
        if let note = menuItems[indexPath.row]["note"] as? String {
            cell.note = note
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = fromXib(class: SimpleTitleView.self)
        if let title = menuItems.first?["title"] as? String {
            headerView?.titleLabel.text = title + (menuItems.count > 0 ? "等" : "")
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = fromStoryboard(class: WebViewController.self) else { return }
        guard let url = menuItems[indexPath.row]["url"] as? String else { return }
        vc.requestUrl = url
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        delegate?.present(vc, animated: false, completion: nil)
    }
}
