//
//  TopicTableViewDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/25.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class TopicTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [TopicTableViewCell.self]
    var category: String = ""
    var jsons: [[String: Any]]?
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(className: TopicTableViewCell.self, indexPath: indexPath)
        if let title = jsons?[indexPath.row]["title"] as? String {
            cell.title = title
        }
        if let link = jsons?[indexPath.row]["link"] as? String {
            cell.link = link
        }
        if let pubDate = jsons?[indexPath.row]["pubDate"] as? String {
            cell.pubDate = pubDate
        }
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = fromXib(class: SimpleTitleView.self)
        headerView?.titleLabel.text = category
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = fromStoryboard(class: WebViewController.self) else { return }
        guard let url = jsons?[indexPath.row]["link"] as? String else { return }
        vc.requestUrl = url
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        UIApplication.shared.topViewController?.present(vc, animated: false, completion: nil)
    }
}
