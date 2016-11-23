//
//  ResultDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/07.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import RealmSwift

class LabelAnnotationTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [LabelAnnotationTableViewCell.self, NoDataTableViewCell.self]
    var labels: List<LabelAnnotation>?
    var translates: List<Translate>?
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        labels = RealmManager.get(CloudVisions.self, key: 0)?.responses.first?.labelAnnotations
        translates = RealmManager.get(Translates.self, key: 0)?.translations
        let count = (labels?.count ?? 0) + (translates?.count ?? 0)
        return count > 0 ? count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let labelCount     = labels?.count ?? 0
        let translateCount = translates?.count ?? 0
        if (labelCount + translateCount) == 0 {
            return tableView.dequeueCell(className: NoDataTableViewCell.self, indexPath: indexPath)
        }
        let cell = tableView.dequeueCell(className: LabelAnnotationTableViewCell.self, indexPath: indexPath)
        // 翻訳なし
        if translateCount == 0 {
            // 元データ
            let label = labels?[indexPath.row]
            if let note = label?.note {
                cell.note = note
            }
            cell.locale = "EN"
            cell.isTranslated = false
        } else {
        // 翻訳あり
            if (indexPath.row % 2) == 0 {
                // 元データ
                let label = labels?[(indexPath.row / 2)]
                if let note = label?.note {
                    cell.note = note
                }
                cell.locale = "EN"
                cell.isTranslated = false
            } else {
                // 翻訳データ
                let translate = translates?[(indexPath.row / 2)]
                if let note = translate?.translatedText {
                    cell.note = note
                }
                cell.locale = "JA"
                cell.isTranslated = true
            }
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
        headerView?.titleLabel.text = "推測されるキーワード"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
}

extension LabelAnnotationTableViewDataSource: LabelAnnotationTableViewCellDelegate {
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
