//
//  BKDateExtension.swift
//  BaseKit
//
//  Created by ldc on 2018/5/29.
//  Copyright © 2018年 Xiamen Hanin. All rights reserved.
//

import Foundation

public extension Date {
    
    static func date(year: Int, month: Int, day: Int) -> Date {
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents)!
    }
    
    func plus(year: Int, month: Int, day: Int) -> Date {
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(byAdding: dateComponents, to: self, wrappingComponents: false)!
    }
    ///日期对应月份天数
    var daysInMonth: Int {
        
        return Calendar.current.range(of: .day, in: .month, for: self)!.count
    }
    
    /// 1: 星期日 7:星期六
    var weekdayIndex: Int {
        
        return Calendar.current.component(.weekday, from: self)
    }
    
    var year: Int {
        
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        
        return Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        
        return Calendar.current.component(.day, from: self)
    }
    
    var hour: Int {
        
        return Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        
        return Calendar.current.component(.minute, from: self)
    }
    
    var second: Int {
        
        return Calendar.current.component(.second, from: self)
    }
    
    func dateString(dateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
