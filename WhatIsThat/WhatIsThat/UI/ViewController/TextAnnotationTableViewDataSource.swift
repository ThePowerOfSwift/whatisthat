//
//  TextAnnotationTableViewDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class TextAnnotationTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [TextAnnotationTableViewCell.self]
    let results = RealmManager.get(CloudVisions.self, key: 0)?.responses.first?.textAnnotations
    var delegate: UIViewController?
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = fromXib(clazz: SimpleTitleView.self)
        headerView?.titleLabel.text = "読み取った文字"
        headerView?.backgroundView.backgroundColor = UIColor.cyan
        return headerView
    }
}

extension TextAnnotationTableViewDataSource: TextAnnotationTableViewCellDelegate {
    func gotoSearchPage(keyword: String, isImageSearch: Bool) {
        guard let vc = fromStoryboard(clazz: WebViewController.self) else { return }
        vc.requestUrl = "https://google.co.jp/search?hl=ja&q=" + keyword + (isImageSearch ? "&tbm=isch" : "")
        print("vc.requestUrl=\(vc.requestUrl)")
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        delegate?.present(vc, animated: false, completion: nil)
    }
}
