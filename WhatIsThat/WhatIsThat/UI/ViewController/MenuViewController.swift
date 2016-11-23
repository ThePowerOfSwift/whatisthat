//
//  MenuViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/28.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class MenuViewController: BaseTableViewController {

    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
        addDataSources()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide navigation header
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func closeAction(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func createTable() -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: 84, width: view.frame.width, height: view.frame.height - 84 - 90), style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.bounces = false
        return tableView
    }
    
    func addDataSources() {
        let settings = MenuItemTableViewDataSource()
        settings.menuItems = [["title": "各種設定", "url": Const.Menu.Url.Contact, "isSetting": true]]
        addDataSource(dataSource: settings)
        
        let service = MenuItemTableViewDataSource()
        service.headerTitle = "サービス情報"
        service.menuItems = [
            ["title": "このアプリについて", "url": Const.Menu.Url.Information],
            ["title": "利用規約", "url": Const.Menu.Url.TermsOfUse],
            ["title": "プライバシーポリシー", "url": Const.Menu.Url.Privacy],
            ["title": "お問い合わせ", "url": Const.Menu.Url.Contact]]
        addDataSource(dataSource: service)
        
        let about = MenuItemTableViewDataSource()
        about.headerTitle = "アプリ情報"
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        about.menuItems = [
            ["title": "ライセンス", "url": Const.Menu.Url.Licence],
            ["title": "バージョン", "note": version]]
        addDataSource(dataSource: about)

        // reloadData
        tableView?.reloadData()
    }
}

