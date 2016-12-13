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
        DispatchQueue.global().async {
            for url in RssHelper().getRssUrls() {
                XmlParser.sharedInstance.loadDataFromFile(filename: url) { [weak self] (data) in
                    if let (category, jsons) = XmlParser.sharedInstance.getArrayFromRssXmlData(data: data) {
                        let datasource = TopicTableViewDataSource()
                        datasource.category = category
                        datasource.jsons = jsons
                        self?.addDataSource(dataSource: datasource)
                        DispatchQueue.main.async {
                            self?.tableView?.reloadData()
                        }
                    }
                }
            }
        }
    }
}

