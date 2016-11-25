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
    let topicTitle: String = ""
    var jsons: [[String: Any]]?
    
    override init() {
        super.init()
        
        jsons = [
            ["category": "社会",
             "title":"ブルブル列島なぜ？　統計初　東京で11月積雪　慌てて野菜収穫も",
             "link": "http://headlines.yahoo.co.jp/hl?a=20161125-00010000-agrinews-soci"],
            ["category": "社会",
             "title":"耕地0．6％減　447万ヘクタール　山間部中心に荒廃増　前年割れ55年連続（日本農業新聞）",
             "link": "http://rdsig.yahoo.co.jp/rss/l/headlines/soci/agrinews/RV=1/RU=aHR0cDovL2hlYWRsaW5lcy55YWhvby5jby5qcC9obD9hPTIwMTYxMTA2LTAwMDEwMDAzLWFncmluZXdzLXNvY2k-"],
            ["category": "社会",
             "title":"野菜高騰の陰で泣く農家　産地の悲しみ知って（日本農業新聞）",
             "link": "http://rdsig.yahoo.co.jp/rss/l/headlines/soci/agrinews/RV=1/RU=aHR0cDovL2hlYWRsaW5lcy55YWhvby5jby5qcC9obD9hPTIwMTYxMTEwLTAwMDEwMDAyLWFncmluZXdzLXNvY2k-"]]
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(className: TopicTableViewCell.self, indexPath: indexPath)
        if let category = jsons?[indexPath.row]["category"] as? String {
            cell.category  = category
        }
        if let title = jsons?[indexPath.row]["title"] as? String {
            cell.title = title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = fromXib(class: SimpleTitleView.self)
        headerView?.titleLabel.text = topicTitle
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
