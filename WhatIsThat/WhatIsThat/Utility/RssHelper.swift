
//
//  RssHelper.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/26.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

class RssHelper: NSObject {
    let rssLinks: [String: String] = [
        "agri":          "http://headlines.yahoo.co.jp/rss/agrinews-loc.xml",
        "body":          "http://headlines.yahoo.co.jp/rss/rescuenow-dom.xml",
        "book":          "http://zasshi.news.yahoo.co.jp/rss/honweb-all.xml",
        "car":           "http://headlines.yahoo.co.jp/rss/norimono-loc.xml",
        "china":         "http://headlines.yahoo.co.jp/rss/macau-c_int.xml",
        "calendar":      "http://zasshi.news.yahoo.co.jp/rss/tokyocal-all.xml",
        "computer":      "http://news.yahoo.co.jp/pickup/computer/rss.xml",
        "education":     "http://zasshi.news.yahoo.co.jp/rss/kyousemi-all.xml",
        "economy":       "http://news.yahoo.co.jp/pickup/economy/rss.xml",
        "entertainment": "http://news.yahoo.co.jp/pickup/entertainment/rss.xml",
        "fashon":        "http://headlines.yahoo.co.jp/rss/fashions-c_life.xml",
        "football":      "http://zasshi.news.yahoo.co.jp/rss/footballc-all.xml",
        "girl":          "http://zasshi.news.yahoo.co.jp/rss/jspa-all.xml",
        "health":        "http://headlines.yahoo.co.jp/rss/it_health-c_life.xml",
        "invest":        "http://headlines.yahoo.co.jp/rss/toushin-c_life.xml",
        "life":          "http://headlines.yahoo.co.jp/rss/suumoj-c_life.xml",
        "live":          "http://headlines.yahoo.co.jp/rss/reallive-c_ent.xml",
        "macau":         "http://headlines.yahoo.co.jp/rss/macau-c_int.xml",
        "money":         "http://headlines.yahoo.co.jp/rss/manetatsun-c_life.xml",
        "movie":         "http://headlines.yahoo.co.jp/rss/piaeiga-c_ent.xml",
        "network":       "headlines.yahoo.co.jp/rss/it_nlab-c_life.xml",
        "risk":          "http://zasshi.news.yahoo.co.jp/rss/riskts-all.xml",
        "school":        "http://headlines.yahoo.co.jp/rss/rshingakun-c_life.xml",
        "sky":           "http://headlines.yahoo.co.jp/rss/wmap-dom.xml",
        "sound":         "http://zasshi.news.yahoo.co.jp/rss/realsound-all.xml",
        "sports":        "http://news.yahoo.co.jp/pickup/sports/rss.xml",
        "stock":         "http://zasshi.news.yahoo.co.jp/rss/shikiho-all.xml",
        "student":       "headlines.yahoo.co.jp/rss/koukousei-c_life.xml",
        "travel":        "headlines.yahoo.co.jp/rss/travelv-bus.xml",
        "voice":         "headlines.yahoo.co.jp/rss/travelv-bus.xml",
        "weather":       "http://headlines.yahoo.co.jp/rss/wmap-dom.xml",
        "woman":         "http://zasshi.news.yahoo.co.jp/rss/jspa-all.xml"
    ]
    
    func getRssUrls() -> [String] {
        var urls = [String]()
        let labels = RealmManager.get(CloudVisions.self, key: 0)?.responses.first?.labelAnnotations
        labels?.forEach({ (label) in
            if rssLinks.keys.contains(label.note) {
                if let link = rssLinks[label.note] {
                    urls.append(link)
                }
            }
        })
        
        if urls.count == 0 {
            var i = 0
            let num = Int(arc4random_uniform(UInt32(rssLinks.count)))
            for key in rssLinks.keys {
                if i == num, let url = rssLinks[key] {
                    urls.append(url)
                    break
                }
                i += 1
            }
        }
        return urls
    }
}
