//
//  MenuViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/28.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class MenuViewController: BaseTableViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
        addDataSources()
    }
    
    @IBAction func closeAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func createTable() -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 100), style: .plain)
        tableView.backgroundColor = UIColor.clear
        return tableView
    }
    
    func addDataSources() {
        // このアプリについて
        let info = MenuItemTableViewDataSource()
        info.menuItems = [["title": "このアプリについて", "url": Const.Menu.Url.Information]]
        info.delegate = self
        addDataSource(dataSource: info)
        
        // お問い合わせ
        let contact = MenuItemTableViewDataSource()
        contact.menuItems = [["title": "お問い合わせ", "url": Const.Menu.Url.Contact]]
        contact.delegate = self
        addDataSource(dataSource: contact)
        
        // 利用規約など
        let etc = MenuItemTableViewDataSource()
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        etc.menuItems = [
            ["title": "利用規約", "url": Const.Menu.Url.TermsOfUse],
            ["title": "プライバシーポリシー", "url": Const.Menu.Url.Privacy],
            ["title": "ライセンス", "url": Const.Menu.Url.Licence],
            ["title": "バージョン", "note": version]]
        etc.delegate = self
        addDataSource(dataSource: etc)

        // reloadData
        tableView?.reloadData()
    }
}

