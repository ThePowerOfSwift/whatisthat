//
//  XmlParser.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/26.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit
import Fuzi

class XmlParser: NSObject {
    
    func loadJsonDataFromRssFile(filename: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: filename) else { return completion(nil) }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                completion(data)
            } else {
                print(error)
            }
        }
        task.resume()
    }
    
    func getArrayFromRssXmlData(data: Data?) -> (String, [[String: Any]]) {
        var category = ""
        var jsons = [[String: Any]]()
        
        guard let data = data else { return (category, jsons) }
        
        do {
            let document = try XMLDocument(data: data)
            //print("get stated. document=\(document)")
            
            if let title = document.firstChild(xpath: "//title")?.stringValue {
                category = title
            }
            
            for element in document.xpath("//item") {
                //print("element=\(element)")
                if let title   = element.children(tag: "title").first?.stringValue,
                   let link    = element.children(tag: "link").first?.stringValue,
                   let pubDate = element.children(tag: "pubDate").first?.stringValue{
                    jsons.append(["title": title, "link": link, "pubDate": pubDate])
                }
            }
        } catch let error {
            print(error)
        }
        return (category, jsons)
    }
}
