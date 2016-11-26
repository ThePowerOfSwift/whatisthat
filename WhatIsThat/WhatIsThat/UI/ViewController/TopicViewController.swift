//
//  TopicViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/25.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import Haneke
import SDWebImage
import UIKit

class TopicViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func createTable() -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 308), style: .plain)
        tableView.backgroundColor = UIColor.clear
        return tableView
    }
    
    func loadData() {
        XmlParser.sharedInstance.loadDataFromFile(filename: "http://news.yahoo.co.jp/pickup/rss.xml") { [weak self] (data) in
            if let (category, jsons) = XmlParser.sharedInstance.getArrayFromRssXmlData(data: data) {
                var i =  0
                let totalNum = jsons.count
                for json in jsons {
                    guard let link = json["link"] as? String else { return }
                    XmlParser.sharedInstance.loadDataFromFile(filename: link) { (data) in
                        let imageFilePath = XmlParser.sharedInstance.getSiteImageFilenameFromData(data: data)
                        if let url = URL(string: imageFilePath) {
                            let cache = Shared.imageCache
                            let imageView = UIImageView()
                            imageView.sd_setImage(with: url, placeholderImage: nil, options: [SDWebImageOptions.continueInBackground, SDWebImageOptions.lowPriority, SDWebImageOptions.refreshCached, SDWebImageOptions.handleCookies, SDWebImageOptions.retryFailed]) { (image, error, cacheType, url) in
                                if let image = image {
                                    cache.set(value: image, key: link)
                                }
                            }
                        }
                    }
                    i += 1
                    if i == totalNum {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            let datasource = TopicTableViewDataSource()
                            datasource.category = category
                            datasource.jsons = jsons
                            self?.addDataSource(dataSource: datasource)
                            self?.tableView?.setNeedsLayout()
                            self?.tableView?.reloadData()
                        }
                    }
                }
            }
        }
    }
}

