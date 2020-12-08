//
//  CalendarConfigure.swift
//  Calendar
//
//  Created by 幻夏。 on 2019/1/23.
//  Copyright © 2019 郑谦. All rights reserved.

import Foundation
import UIKit

enum CalendarItemType: Int {
	case squartAlone = 0
	case squartCollect
	case circleAlone
	case circleCollect
}

enum CalendarChooseType: Int {
	/// 日期单选
	case single = 0
	/// 日期双选
	case double
}
extension String {
	public var intValue: Int {
		get {
			return (self as NSString).integerValue
		}
	}
}
