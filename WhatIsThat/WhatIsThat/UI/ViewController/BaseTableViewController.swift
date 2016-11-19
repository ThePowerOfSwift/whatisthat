//
//  BaseTableViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/06.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

protocol BaseTableViewControllerProtocol: UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView? { get set }
    var datasouces: [BaseTableViewDataSource] { get set }
    func addDataSource(dataSource: BaseTableViewDataSource)
    func resetDataSources()
    func createTable() -> UITableView
}

class BaseTableViewController: UIViewController, BaseTableViewControllerProtocol {
    internal var tableView: UITableView?
    internal var datasouces = [BaseTableViewDataSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = createTable()
        if let tableView = tableView {
            view.addSubview(tableView)
            tableView.dataSource = self
            tableView.delegate   = self
            tableView.rowHeight  = UITableViewAutomaticDimension
            tableView.tableFooterView = UIView()
        }
    }
    
    internal func addDataSource(dataSource: BaseTableViewDataSource) {
        datasouces.append(dataSource)
        dataSource.viewClasses?.forEach({ (viewClass) in
            tableView?.register(className: viewClass)
        })
    }
    
    func resetDataSources() {
        datasouces = []
    }
    
    func createTable() -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain)
        tableView.backgroundColor = UIColor.clear
        return tableView
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasouces.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasouces[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return datasouces[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return datasouces[indexPath.section].tableView?(tableView, heightForRowAt: indexPath) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return datasouces[section].tableView?(tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return datasouces[section].tableView?(tableView, heightForHeaderInSection: 0) ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        datasouces[indexPath.section].tableView?(tableView, didSelectRowAt: indexPath)
    }
}
