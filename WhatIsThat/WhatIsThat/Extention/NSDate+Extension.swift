//
//  NSDate+Extension.swift
//  WhatIsThat
//
//  Created by 渡邊浩二 on 2016/11/20.
//  Copyright © 2016年 渡邊浩二. All rights reserved.
//

import UIKit

extension Date {
    var calendar: Calendar {
        return Calendar(identifier: Calendar.Identifier.gregorian)
    }
    
    func equalsTo(date: Date) -> Bool {
        return self.compare(date) == ComparisonResult.orderedSame
    }
    
    func greaterThan(date: Date) -> Bool {
        return self.compare(date) == ComparisonResult.orderedDescending
    }
    
    func lessThan(date: Date) -> Bool {
        return self.compare(date) == ComparisonResult.orderedAscending
    }
    
    static func parse(dateString: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
    
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = calendar
        return formatter.string(from: self)
    }
}
