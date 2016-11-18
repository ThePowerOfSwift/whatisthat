//
//  FaceAnnotationTableViewDataSource.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/13.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class FaceAnnotationTableViewDataSource: NSObject, BaseTableViewDataSource {
    internal var viewClasses: [UITableViewCell.Type]? = [FaceAnnotationTableViewCell.self]
    let results = RealmManager.get(CloudVisions.self, key: 0)?.responses.first?.faceAnnotations
    var delegate: UIViewController?
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(className: FaceAnnotationTableViewCell.self, indexPath: indexPath)
        if let detectionConfidence = results?[indexPath.row].detectionConfidence {
            cell.detectionConfidence = String(detectionConfidence)
        }
        if let landmarkingConfidence = results?[indexPath.row].landmarkingConfidence {
            cell.landmarkingConfidence = String(landmarkingConfidence)
        }
        if let joyLikelihood = results?[indexPath.row].joyLikelihood {
            cell.joyLikelihood = String(joyLikelihood)
        }
        if let sorrowLikelihood = results?[indexPath.row].sorrowLikelihood {
            cell.sorrowLikelihood = String(sorrowLikelihood)
        }
        if let angerLikelihood = results?[indexPath.row].angerLikelihood {
            cell.angerLikelihood = String(angerLikelihood)
        }
        if let surpriseLikelihood = results?[indexPath.row].surpriseLikelihood {
            cell.surpriseLikelihood = String(surpriseLikelihood)
        }
        if let underExposedLikelihood = results?[indexPath.row].underExposedLikelihood {
            cell.underExposedLikelihood = String(underExposedLikelihood)
        }
        if let blurredLikelihood = results?[indexPath.row].blurredLikelihood {
            cell.blurredLikelihood = String(blurredLikelihood)
        }
        if let headwearLikelihood = results?[indexPath.row].headwearLikelihood {
            cell.headwearLikelihood = String(headwearLikelihood)
        }
        cell.setContent()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = fromXib(class: SimpleTitleView.self)
        headerView?.titleLabel.text = "顔検知"
        headerView?.backgroundView.backgroundColor = UIColor.orange
        return headerView
    }
}
