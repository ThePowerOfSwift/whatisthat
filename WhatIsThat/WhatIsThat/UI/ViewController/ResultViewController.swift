//
//  ResultViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/10/16.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import ObjectMapper
import RealmSwift
import UIKit

class ResultViewController: BaseTableViewController {
    @IBOutlet weak var loadingVIew: UIView!

    let headerView  = fromXib(clazz: SimpleImageView.self)
    var tappedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tappedImage = tappedImage else { return }
        
        // Loading
        view.bringSubview(toFront: loadingVIew)
        loadingVIew.isHidden = false
        
        // Header
        if let headerView = headerView {
            headerView.mainImage = tappedImage
            headerView.delegate = self
            view.addSubview(headerView)
        }
        
        // API Request
        CloudVisionManager().getData(image: tappedImage) { (response) in
            switch response {
            case .success:
                debugPrint("API request is succeeded.")
                self.addDataSource()
                self.tableView?.reloadData()
            case .failure(let error):
                debugPrint(error)
            }
            self.loadingVIew.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addDataSource() {
        // Label
        let label = LabelAnnotationTableViewDataSource()
        label.delegate = self
        self.addDataSource(dataSource: label)
        
        // Text
        let text = TextAnnotationTableViewDataSource()
        text.delegate = self
        self.addDataSource(dataSource: text)
        
        // Logo
        let logo = LogoAnnotationTableViewDataSource()
        logo.delegate = self
        self.addDataSource(dataSource: logo)
        
        // Landmark
        let landmark = LandmarkAnnotationTableViewDataSource()
        landmark.delegate = self
        self.addDataSource(dataSource: landmark)
        
        // Face
        let face = FaceAnnotationTableViewDataSource()
        face.delegate = self
        self.addDataSource(dataSource: face)

        // Safe Search
        let safeSearch = SafeSearchAnnotationTableViewDataSource()
        self.addDataSource(dataSource: safeSearch)
    }
    
    override func createTable() -> UITableView {
        let headerHeight = headerView?.frame.size.height ?? 0
        let tableView = UITableView(frame: CGRect(x: 0, y: headerHeight, width: Const.Screen.Size.width, height: Const.Screen.Size.height - headerHeight), style: .plain)
        tableView.backgroundColor = UIColor.clear
        return tableView
    }
}

extension ResultViewController: SimpleImageViewDelegate {
    func tappedCancelButton() {
        dismiss(animated: false, completion: nil)
    }
}

