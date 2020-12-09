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
    
    private(set) var startDate: Date = Date(timeIntervalSince1970: 946656000)
    
    private(set) var endDate: Date = Date()
    
    private lazy var calendar: Calendar = {
        return Calendar(identifier: .gregorian)
    }()
    
    private lazy var timeZone: NSTimeZone = {
        return NSTimeZone.init(name: "Asia/Shanghai")!
    }()
    
    private lazy var components: DateComponents = {
        return DateComponents.init()
    }()
    
    private lazy var formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format
    }()
    
//    private var weekDays: [String] = ["0","1","2","3","4","5","6"]
    private lazy var weekDays: NSArray = {
        return [NSNull.init(), "0","1","2","3","4","5","6"]
    }()
    
}

extension DKLCalendarManager {
    private func initialze() {
        for i in startDate.year...endDate.year {
            if i == startDate.year {
                for j in startDate.month...12 {
                    let year = String(format: "%ld年%02d月", i, j)
                    sections.append(year)
                }
            }else if i == endDate.year {
                for j in 1...endDate.month {
                    let year = String(format: "%ld年%02d月", i, j)
                    sections.append(year)
                }
            }else {
                for j in 1...12 {
                    let year = String(format: "%ld年%02d月", i, j)
                    sections.append(year)
                }
            }
        }
        
        
        
//        for i in startDate.year...endDate.year {
//            if i == startDate.year {
//                for j in startDate.month...12 {
//                    let year = String(format: "%ld年%02d月", i, j)
//                    sections.append(year)
//                    var tmpDays: [String] = []
//                    for d in 1...self.daysWithYear(i, andMonth: j) {
//                        let day = String(format: "%02d", d)
//                        tmpDays.append(day)
//                    }
//                    self.days.append(tmpDays)
//                }
//            }else if i == endDate.year {
//                for j in 1...endDate.month {
//                    let year = String(format: "%ld年%02d月", i, j)
//                    sections.append(year)
//                    var tmpDays: [String] = []
//                    for d in 1...self.daysWithYear(i, andMonth: j) {
//                        let day = String(format: "%02d", d)
//                        tmpDays.append(day)
//                    }
//                    self.days.append(tmpDays)
//                }
//            }else {
//                for j in 1...12 {
//                    let year = String(format: "%ld年%02d月", i, j)
//                    sections.append(year)
//                    var tmpDays: [String] = []
//                    for d in 1...self.daysWithYear(i, andMonth: j) {
//                        let day = String(format: "%02d", d)
//                        tmpDays.append(day)
//                    }
//                    self.days.append(tmpDays)
//                }
//            }
//        }
        
    }
    
    /// 获取每一个section有多少个item
    func GetTotalItemsIn(_ section: Int) -> Int {
        let dateTime = self.GetEarlierAndLaterDaysFrom(date: endDate, andMonth: section)
        let firstTime = self.GetStartDayInSection(dateTime)
        let firstCount = (firstTime as NSString).integerValue
        let totalyDays = self.GetTotalDaysInMonth(dateTime)
        return firstCount + totalyDays
    }
    /// 获取当前时间和以后时间各有多少个月, 0为当前月
    func GetEarlierAndLaterDaysFrom(date: Date, andMonth month: Int) -> Date {
        let newDate = Date()
        let comps = self.GetCurrentComponentsWith(date: newDate)
        let year = comps.year!
        let tmpMonth = comps.month!
        let monthCount = (year-startDate.year)*12
        let months = month-monthCount-tmpMonth+1
        self.components.month = months
        let resultDate = self.calendar.date(byAdding: self.components, to: date)
        return resultDate!
    }
    /// 获取每个单位内开始的时间
    func GetStartDayInSection(_ date: Date) -> String {
        var count: TimeInterval = 0
        var beginDate: NSDate!
        let firstTime = (self.calendar as NSCalendar).range(of: NSCalendar.Unit.month, start: &beginDate, interval: &count, for: date)
        if firstTime {
            self.calendar.timeZone = self.timeZone as TimeZone
            let com = self.calendar.dateComponents(Set<Calendar.Component>(arrayLiteral: Calendar.Component.weekday), from: beginDate as Date)
            let str = self.weekDays.object(at: com.weekday!) as! String
            return str
        }else {
            return ""
        }
    }
    /// 获取每个月一共多少天
    func GetTotalDaysInMonth(_ date: Date) -> Int{
        let cal = Calendar.current
        let range = (cal as NSCalendar).range(of: .day, in: .month, for: date)
        return range.length
    }
    /// 获取当前日期零件
    func GetCurrentComponentsWith(date: Date) -> DateComponents{
        let cal = Calendar.current
        let result = cal.dateComponents(Set<Calendar.Component>(arrayLiteral: Calendar.Component.year,Calendar.Component.month,Calendar.Component.day), from: date)
        return result
    }
    
    /// 获取当前时间的年月日
    func GetYear(_ date: Date) -> Int {
        return self.GetCurrentComponentsWith(date: date).year!
    }
    func GetMonth(_ date: Date) -> Int {
        return self.GetCurrentComponentsWith(date: date).month!
    }
    func GetDay(_ date: Date) -> Int {
        return self.GetCurrentComponentsWith(date: date).day!
    }
}

extension DKLCalendarManager {
    
}

extension Date {
    
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
