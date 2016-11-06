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

class ResultViewController: UIViewController {
    @IBOutlet weak var targetImageView:      UIImageView!
    @IBOutlet weak var descriptionTableView: UITableView!
    @IBOutlet weak var ocrTableView:         UITableView!
    @IBOutlet weak var itemTableView:        UITableView!
    @IBOutlet weak var faceTableView:        UITableView!
    @IBOutlet weak var shopTableView:        UITableView!
    
    enum ListNameOfTableView: Int {
        case DescriptionList
        case OcrList
        case ItamList
        case FaceList
        case ShopList
    }
    
    let loadingView = fromXib(clazz: LoadingView.self)
    var tappedImage: UIImage? = nil
    var faceAnnotations      = List<FaceAnnotation>()
    var landmarkAnnotations  = List<LandmarkAnnotation>()
    var labelAnnotations     = List<LabelAnnotation>()
    var logoAnnotations      = List<LogoAnnotation>()
    var safeSearchAnnotation: SafeSearchAnnotation? = nil
    var textAnnotations      = List<TextAnnotation>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        targetImageView.image = tappedImage
        
        loadingView?.show()
        
        CloudVisionManager().getData(image: tappedImage!) { (response) in
            self.loadingView?.hide()
            switch response {
            case .success:
                debugPrint("API request is succeeded.")
                self.loadData()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadData() {
        guard let result = RealmManager.get(CloudVisions.self, key: 0)?.responses.first else { return }
        debugPrint("[Local DB] result=\(result)")
        if result.faceAnnotations.count > 0 {
            faceAnnotations = result.faceAnnotations
            faceTableView.reloadData()
        }
        if result.landmarkAnnotations.count > 0 {
            landmarkAnnotations = result.landmarkAnnotations
            descriptionTableView.reloadData()
        }
        if result.labelAnnotations.count > 0 {
            labelAnnotations = result.labelAnnotations
            descriptionTableView.reloadData()
        }
        if result.logoAnnotations.count > 0 {
            logoAnnotations = result.logoAnnotations
            descriptionTableView.reloadData()
        }
        if result.safeSearchAnnotation != nil {
            safeSearchAnnotation = result.safeSearchAnnotation
        }
        if result.textAnnotations.count > 0 {
            textAnnotations = result.textAnnotations
            ocrTableView.reloadData()
        }
    }

    @IBAction func tappedBackgroundView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == ListNameOfTableView.DescriptionList.rawValue {
            return labelAnnotations.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        if tableView.tag == ListNameOfTableView.DescriptionList.rawValue {
            cell.textLabel?.text = labelAnnotations[indexPath.row].note
        }
        return cell
    }
}

extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.0
    }
}
