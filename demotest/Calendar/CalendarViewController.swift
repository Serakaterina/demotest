//
//  CalendarViewController.swift
//  Calendar
//
//  Created by 幻夏。 on 2019/1/23.
//  Copyright © 2019 郑谦. All rights reserved.
//

import UIKit

typealias GetTimeBlock = (_ startDate: String, _ endDate: String) -> Void

private let startTime: Int = 2019

private let s_w = UIScreen.main.bounds.size.width

private let s_h = UIScreen.main.bounds.size.height

class CalendarViewController: UIViewController {

	var selectTimeBlock: GetTimeBlock?
    var selectColor: UIColor = UIColor.black
	var normalColor: UIColor = UIColor.clear
	var middleColor: UIColor = UIColor.black.withAlphaComponent(0.7)
	var itemType: CalendarItemType = CalendarItemType.squartCollect
	var chooseType: CalendarChooseType = CalendarChooseType.double
	
	fileprivate let cellID = "CalendarCell"
	fileprivate let headerID = "CalendarReusableHeader"
	
	fileprivate var startDate: [String]!
	fileprivate var endDate: [String]!
	fileprivate var nowDateString:[String]!
	fileprivate var cv: UICollectionView!
	fileprivate lazy var nowDate: Date = {
		return Date()
	}()
	fileprivate lazy var timeZone: NSTimeZone = {
		return NSTimeZone.init(name: "Asia/Shanghai")!
	}()
	fileprivate lazy var calendar: Calendar = {
		return Calendar.init(identifier: Calendar.Identifier.gregorian)
	}()
	fileprivate lazy var components: DateComponents = {
		return DateComponents.init()
	}()
	fileprivate lazy var formatter: DateFormatter = {
		let format = DateFormatter()
		format.dateFormat = "yyyy-MM-dd"
		return format
	}()
	fileprivate lazy var weekDays: NSArray = {
		return [NSNull.init(), "0","1","2","3","4","5","6"]
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		title = "选择日期"

		if nowDateString == nil {
			let nowY = "\(GetYear(nowDate))"
			let nowM = GetMonth(nowDate) < 10 ? "0\(GetMonth(nowDate))" : "\(GetMonth(nowDate))"
			let nowD = GetDay(nowDate) < 10 ? "0\(GetDay(nowDate))" : "\(GetDay(nowDate))"
			self.nowDateString = [nowY, nowM, nowD]
		}

		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize.init(width: s_w/7, height: s_w/7)
		layout.scrollDirection = .vertical
		layout.headerReferenceSize = CGSize.init(width: s_w, height: 50)
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.sectionInset = .zero
		
		cv = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: s_w, height: s_h), collectionViewLayout: layout)
		cv.backgroundColor = UIColor.clear
		cv.delegate = self
		cv.dataSource = self
		cv.register(UINib.init(nibName: "CalendarViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        cv.register(UINib.init(nibName: "CalendarViewReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
		self.view.addSubview(cv)
	}
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		let now = Date()
		let cal = Calendar.current
		let comps = cal.dateComponents(Set<Calendar.Component>(arrayLiteral: .year, .month, .day, .hour, .minute, .second), from: now)
		let year = comps.year!
		let month = comps.month!
		let day = comps.day!
		let months = (year-startTime)*12+month-1
		let indexPath = IndexPath.init(item: day, section: months)
		self.cv.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
	}
	deinit {
		
	}
}
extension CalendarViewController {
	/// 获取当前时间和以后时间各有多少个月, 0为当前月
	fileprivate func GetEarlierAndLaterDaysFrom(date: Date, andMonth month: Int) -> Date {
		let newDate = Date()
		let comps = self.GetCurrentComponentsWith(date: newDate)
		let year = comps.year!
		let tmpMonth = comps.month!
		let monthCount = (year-startTime)*12
		let months = month-monthCount-tmpMonth+1
		self.components.month = months
		let resultDate = self.calendar.date(byAdding: self.components, to: date)
		return resultDate!
	}
	/// 获取每个单位内开始的时间
	fileprivate func GetStartDayInSection(_ date: Date) -> String {
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
	fileprivate func GetTotalDaysInMonth(_ date: Date) -> Int{
		let cal = Calendar.current
		let range = (cal as NSCalendar).range(of: .day, in: .month, for: date)
		return range.length
	}
	
	/// 获取当前的日期格式
	fileprivate func GetCurrentDateFormatterWith(_ date: Date, andMonth month: Int) -> [String] {
		
		let dateTime = self.GetEarlierAndLaterDaysFrom(date: self.nowDate, andMonth: month)
		let format = self.formatter.string(from: dateTime)
		let result = format.components(separatedBy: "-")
		return result
	}
	/// 获取当前日期零件
	fileprivate func GetCurrentComponentsWith(date: Date) -> DateComponents{
		let cal = Calendar.current
		let result = cal.dateComponents(Set<Calendar.Component>(arrayLiteral: Calendar.Component.year,Calendar.Component.month,Calendar.Component.day), from: date)
		return result
	}
	/// 获取当前时间的年月日
	fileprivate func GetYear(_ date: Date) -> Int {
		return self.GetCurrentComponentsWith(date: date).year!
	}
	fileprivate func GetMonth(_ date: Date) -> Int {
		return self.GetCurrentComponentsWith(date: date).month!
	}
	fileprivate func GetDay(_ date: Date) -> Int {
		return self.GetCurrentComponentsWith(date: date).day!
	}
	
	/// 根据起止年月获取总月数
	fileprivate func GetTotalMonths() -> Int {
		let cal = Calendar.current
		let year = cal.component(.year, from: nowDate)
		let month = cal.component(.month, from: nowDate)
		let total = (year - startTime)*12+month
		return total
	}
	/// 获取每一个section有多少个item
	fileprivate func GetTotalItemsIn(_ section: Int) -> Int {
		let dateTime = self.GetEarlierAndLaterDaysFrom(date: nowDate, andMonth: section)
		let firstTime = self.GetStartDayInSection(dateTime)
		let firstCount = (firstTime as NSString).integerValue
		let totalyDays = self.GetTotalDaysInMonth(dateTime)
		return firstCount + totalyDays
	}
}





extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return GetTotalMonths()
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return GetTotalItemsIn(section)
	}
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! CalendarViewReusableView
			header.showTimeWith(self.GetCurrentDateFormatterWith(nowDate, andMonth: indexPath.section))
			return header
		}
		return UICollectionReusableView()
	}
	
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CalendarViewCell
		
		let dateTime = self.GetEarlierAndLaterDaysFrom(date: nowDate, andMonth: indexPath.section)
		let dayIndex = indexPath.row-(self.GetStartDayInSection(dateTime) as NSString).integerValue+1
		let cellTextString = dayIndex > 0 ? "\(dayIndex)" : ""
		cell.day.text = cellTextString
		
		cell.type = self.itemType
		
		let year = "\(GetYear(dateTime))"
		
		var month = ""
		if GetMonth(dateTime)<10 {
			month = "0"+"\(GetMonth(dateTime))"
		}else {
			month = "\(GetMonth(dateTime))"
		}
		
		var day = ""
		if dayIndex < 10 {
			day = "0"+"\(dayIndex)"
		}else {
			day = "\(dayIndex)"
		}
		let current = [year, month, day]
		cell.reloadCellWith(self.startDate ?? [], current, self.endDate ?? [], self.nowDateString!, self.selectColor, self.middleColor, self.normalColor)
		cell.backgroundColor = UIColor.clear
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let dateTime = self.GetEarlierAndLaterDaysFrom(date: nowDate, andMonth: indexPath.section)
		let dayIndex = indexPath.row-self.GetStartDayInSection(dateTime).intValue+1
		let comp = self.GetCurrentComponentsWith(date: dateTime)
		let selectY = "\(comp.year!)"
		
		var selectM = ""
		if comp.month! < 10 {
			selectM = "0"+"\(comp.month!)"
		}else {
			selectM = "\(comp.month!)"
		}
		
		var selectD = ""
		if dayIndex < 10 {
			selectD = "0"+"\(dayIndex)"
		}else {
			selectD = "\(dayIndex)"
		}
		
		if chooseType == .single {
			self.startDate = [selectY, selectM, selectD]
			self.endDate = [selectY, selectM, selectD]
			self.cv.reloadData()
			print("单选日期, 开始和结束都是同一天, 直接返回, 日期是:\n\(startDate!)\n\(endDate!)")
		}else {
			
			if startDate == nil {
				startDate = [selectY, selectM, selectD]
				self.cv.reloadData()
			}else {
				if endDate == nil {
					/// 此处为开始日期不为空, 然后点击的日期为截止时间, 这个时候表明选中了一段日期, 则返回
					endDate = [selectY, selectM, selectD]
					self.cv.reloadData()
					self.back()
				}else {
					/// 开始/结束日期都不为空, 那么证明已经选择过一段时间, 需要先全部清空然后给开始q日期赋值
					startDate = nil
					endDate = nil
					startDate = [selectY, selectM, selectD]
					self.cv.reloadData()
				}
			}
		}
	}
}
extension CalendarViewController {
	
	fileprivate func back() {
		
		let start = "\(startDate[0])-\(startDate[1])-\(startDate[2])"
		
		let end = "\(endDate[0])-\(endDate[1])-\(endDate[2])"
		
		var startTime = ""
		var endTime = ""
		if start > end {
			startTime = end
			endTime = start
		}else if start == end {
			startTime = start
			endTime = start
		}else {
			startTime = start
			endTime = end
		}

		if selectTimeBlock != nil {
			selectTimeBlock!(startTime, endTime)
		}
		self.perform(#selector(finalBackDateString), with: nil, afterDelay: 0.5)
		
	}
	@objc private func finalBackDateString() {
		self.navigationController?.popViewController(animated: true)
	}
	
	
}
