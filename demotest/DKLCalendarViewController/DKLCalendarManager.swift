//
//  DKLCalendarManager.swift
//  demotest
//
//  Created by Serakaterina on 2020/12/8.
//

import UIKit

class DKLCalendarManager: NSObject {

    override init() {
        super.init()
        self.initialze()
    }
    
    private(set) var sections: [String] = []
    
    private(set) var days: [[String]] = []
    
    private var startDate: Date = Date(timeIntervalSince1970: 946656000)
    
    private var endDate: Date = Date()
    
}

extension DKLCalendarManager {
    private func initialze() {
        for i in startDate.year...endDate.year {
            if i == startDate.year {
                for j in startDate.month...12 {
                    let year = String(format: "%ld年%02d月", i, j)
                    sections.append(year)
                    var tmpDays: [String] = []
                    for d in 1...self.daysWithYear(i, andMonth: j) {
                        let day = String(format: "%02d", d)
                        tmpDays.append(day)
                    }
                    self.days.append(tmpDays)
                }
            }else if i == endDate.year {
                for j in 1...endDate.month {
                    let year = String(format: "%ld年%02d月", i, j)
                    sections.append(year)
                    var tmpDays: [String] = []
                    for d in 1...self.daysWithYear(i, andMonth: j) {
                        let day = String(format: "%02d", d)
                        tmpDays.append(day)
                    }
                    self.days.append(tmpDays)
                }
            }else {
                for j in 1...12 {
                    let year = String(format: "%ld年%02d月", i, j)
                    sections.append(year)
                    var tmpDays: [String] = []
                    for d in 1...self.daysWithYear(i, andMonth: j) {
                        let day = String(format: "%02d", d)
                        tmpDays.append(day)
                    }
                    self.days.append(tmpDays)
                }
            }
        }
    }
    
    /// 通过年月求每月的天数
    private func daysWithYear(_ year: Int, andMonth month: Int) -> Int {
        
        let isLeapYear = year % 400 == 0 ? true : (year % 4 == 0 && year % 100 != 0)
        
        switch month {
        
        case 4: fallthrough
            
        case 6: fallthrough
            
        case 9: fallthrough
            
        case 11:
            
            return 30
            
        case 2:
            
            if isLeapYear {
                
                return 29
                
            }else {
                
                return 28
                
            }
            
        default:
            
            return 31
            
        }
        
    }
    
}

extension DKLCalendarManager {
    
}

private extension Date {
    
    private static let dklDate_calendar = Calendar.autoupdatingCurrent
    
    var year: Int {
        get {
            return Date.dklDate_calendar.component(.year, from: self)
        }
    }
    
    var month: Int {
        get {
            return Date.dklDate_calendar.component(.month, from: self)
        }
    }
    
    var day: Int {
        get {
            return Date.dklDate_calendar.component(.day, from: self)
        }
    }
    
    /// 该日期对应的月一共有多少天
    var dklDate_daysInCurrentMonth: Int {
        get {
            return (Date.dklDate_calendar as NSCalendar).range(of: .day, in: .month, for: self).length
        }
    }
}
