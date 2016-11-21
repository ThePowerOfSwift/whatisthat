//
//  TextAnnotationTableViewDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class TextAnnotationTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [TextAnnotationTableViewCell.self, NoDataTableViewCell.self]
    let results = RealmManager.get(CloudVisions.self, key: 0)?.responses.first?.textAnnotations
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = results?.count ?? 0
        return count > 0 ? count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (results?.count ?? 0) == 0 {
            return tableView.dequeueCell(className: NoDataTableViewCell.self, indexPath: indexPath)
        }
        let cell = tableView.dequeueCell(className: TextAnnotationTableViewCell.self, indexPath: indexPath)
        if let locale = results?[indexPath.row].locale {
            cell.locale = locale
        }
        if let note = results?[indexPath.row].note {
            cell.note = note
        }
        cell.delegate = self
        cell.setContent()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = fromXib(class: SimpleTitleView.self)
        headerView?.titleLabel.text = "読み取った文字"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
}

extension TextAnnotationTableViewDataSource: TextAnnotationTableViewCellDelegate {
    func gotoSearchPage(keyword: String, isImageSearch: Bool) {
        guard let vc = fromStoryboard(class: WebViewController.self) else { return }
        guard let keyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        vc.requestUrl = "https://google.co.jp/search?hl=ja&q=" + keyword + (isImageSearch ? "&tbm=isch" : "")
        print("vc.requestUrl=\(vc.requestUrl)")
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        UIApplication.shared.topViewController?.present(vc, animated: false, completion: nil)
    }
}
