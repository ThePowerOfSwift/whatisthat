//
//  WeatherViewController.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/18.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cloud: UILabel!
    @IBOutlet weak var wind: UILabel!
    
    var tappedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set main image
        mainImageView.image = tappedImage
        
        // Loading Indicator
        view.bringSubview(toFront: loadingView)
        view.bringSubview(toFront: contentView)
        
        // API Request
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        loadingView.isHidden = false
        WeatherMapManager().getData(cityname: "Tokyo") { (response) in
            switch response {
            case .success:
                debugPrint("WeatherMap API request is succeeded.")
                self.updateDisplay()
            case .failure(let error):
                debugPrint(error)
                self.showAlert()
            }
            self.loadingView.isHidden = true
        }
    }
    
    func updateDisplay() {
        contentView.isHidden = false
        guard let result = RealmManager.get(WeatherMap.self, key: 0) else { return }
        print("result=\(result)")
        name.text = result.name
        cloud.text = "最低気温：\(result.list.first?.tempMin)"
        wind.text = "天気：\(result.list.first?.weather.first?.note)"
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "通信エラー",
            message: "データの取得に失敗しました。\n\n電波状況をお確かめの上、\n再度ご利用ください。",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "リトライ",
                                      style: .default,
                                      handler:{ action in
                                        self.loadData()
        }))
        alert.addAction(UIAlertAction(title: "戻る",
                                      style: .cancel,
                                      handler:{ action in
                                        self.dismiss(animated: false, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
