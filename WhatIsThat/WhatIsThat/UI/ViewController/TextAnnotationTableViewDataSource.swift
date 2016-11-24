//
//  TextAnnotationTableViewDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import RealmSwift
import UIKit

class TextAnnotationTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [TextAnnotationTableViewCell.self, NoDataTableViewCell.self]
    var texts: List<TextAnnotation>?
    var translates: List<Translate>?
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        texts = RealmManager.get(CloudVisions.self, key: 0)?.responses.first?.textAnnotations
        translates = RealmManager.get(Translates.self, key: CloudVisionTypeId.Text.rawValue)?.translations
        let textCount      = (texts?.count ?? 0)      > 0 ? 1 : 0
        let translateCount = (translates?.count ?? 0) > 0 ? 1 : 0
        let count          = (textCount + translateCount) > 0 ? (textCount + translateCount) : 1
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textCount      = (texts?.count ?? 0)      > 0 ? 1 : 0
        let translateCount = (translates?.count ?? 0) > 0 ? 1 : 0
        if (textCount + translateCount) == 0 {
            return tableView.dequeueCell(className: NoDataTableViewCell.self, indexPath: indexPath)
        }
        let cell = tableView.dequeueCell(className: TextAnnotationTableViewCell.self, indexPath: indexPath)
        if indexPath.row == 0 {
            // 元データ
            let text = texts?.first
            if let note = text?.note {
                cell.note = note
            }
            if translateCount > 0, let locale = translates?.first?.detectedSourceLanguage {
                cell.locale = locale
            } else if let locale = text?.locale {
                cell.locale = locale
            }
            cell.isTranslated = false
        } else {
            // 翻訳データ
            let translate = translates?.first
            if let note = translate?.translatedText {
                cell.note = note
            }
            if let locale = translate?.detectedSourceLanguage, locale == "ja" {
                cell.locale = "EN"
            } else {
                cell.locale = "JA"
            }
            cell.isTranslated = true
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
