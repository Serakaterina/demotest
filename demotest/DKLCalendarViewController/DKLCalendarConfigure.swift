//
//  DKLCalendarConfigure.swift
//  demotest
//
//  Created by Serakaterina on 2020/12/8.
//

import Foundation

struct DKLCalendarConfig {
    /// 背景色默认#F5F5F5
    static let backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
    
    /// 年月标题色默认#333333
    static let headerYearMonthTextColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
    
    /// 年月标题字体 默认粗体14
    static let headerYearMonthTextFont = UIFont.boldSystemFont(ofSize: 14)
    
    /// 日期字体颜色#666666
    static let dayTextColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
    
    /// 日期字体 默认 12
    static let dayTextFont = UIFont.systemFont(ofSize: 16)
    
    /// 日期选中的颜色
    static let daySelectTextColor = UIColor.white
    
    /// 日期选择的背景色
    static let daySelectBackColor = UIColor(red: 7.0/255.0, green: 192.0/255.0, blue: 194.0/255.0, alpha: 1)
    
    /// 日期中间标记字体颜色 默认白色
    static let dayInnerTagTextColor = UIColor.white
    
    /// 日期中间标记背景颜色
    static let dayInnerTagBackColor = UIColor(red: 7.0/255.0, green: 192.0/255.0, blue: 194.0/255.0, alpha: 1).withAlphaComponent(0.4)
    
    /// 日期不可选颜色
    static let dayUnselectColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1)
}

