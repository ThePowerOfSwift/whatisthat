//
//  ResultDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/07.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class ResultTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [ResultTableViewCell.self]
    let results = RealmManager.getAll(CloudVision.self)
    var delegate: UIViewController?
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.first?.labelAnnotations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(className: ResultTableViewCell.self, indexPath: indexPath)
        if let note = results?.first?.labelAnnotations[indexPath.row].note {
            cell.note = note
        }
        cell.delegate = self
        return cell
    }
}

extension ResultTableViewDataSource: ResultTableViewCellDelegate {
    func gotoSearchPage(keyword: String, isImageSearch: Bool) {
        guard let vc = fromStoryboard(clazz: WebViewController.self) else { return }
        vc.requestUrl = "https://google.co.jp/search?hl=ja&q=" + keyword + (isImageSearch ? "&tbm=isch" : "")
        print("vc.requestUrl=\(vc.requestUrl)")
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle   = UIModalTransitionStyle.crossDissolve
        delegate?.present(vc, animated: false, completion: nil)
    }
}
