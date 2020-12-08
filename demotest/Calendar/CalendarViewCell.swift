//
//  CalendarViewCell.swift
//  Calendar
//
//  Created by 幻夏。 on 2019/1/23.
//  Copyright © 2019 郑谦. All rights reserved.
//

import UIKit

class CalendarViewCell: UICollectionViewCell {

	@IBOutlet weak var day: UILabel!
	
	@IBOutlet weak var status: UILabel!
	
	var type: CalendarItemType!
	
	override func draw(_ rect: CGRect) {
		if let newType = type {
			if newType == .circleAlone || newType == .circleCollect {
				let tmpRect = CGRect.init(x: (day.bounds.width-32)/2, y: (day.bounds.height-32)/2, width: 32, height: 32)
				day.layer.cornerRadius = 16
				day.layer.masksToBounds = true
				day.frame = tmpRect
			}
		}
	}
	
	func reloadCellWith(_ startDay: [String],
						_ currentDay: [String],
						_ endDay: [String],
						_ nowDay: [String],
						_ selectColor: UIColor,
						_ middleColor: UIColor,
						_ normalColor: UIColor)
	{
		
		if currentDay[2].intValue > 0 {
			self.isHidden = false
		}else {
			self.isHidden = true
		}
		
		let curre = "\(currentDay[0])\(currentDay[1])\(currentDay[2])"
		let now = "\(nowDay[0])\(nowDay[1])\(nowDay[2])"
		
		if startDay.count == 0 {
			day.backgroundColor = normalColor
			status.text = ""
			if curre > now {
//				day.textColor = JIUJIU
				self.isUserInteractionEnabled = false
			}else if curre == now {
//				day.textColor = FF8EAC
				/// "今天"
				status.text = ""
				status.textColor = UIColor.red
				self.isUserInteractionEnabled = true
			}else {
//				day.textColor = LIULIU
				self.isUserInteractionEnabled = true
			}
		}else if endDay.count == 0 {
			if startDay == currentDay {
				day.backgroundColor = selectColor
				day.textColor = UIColor.white
				status.text = "开始"
				status.textColor = UIColor.white
			}else {
				day.backgroundColor = normalColor
				status.text = ""
				if curre > now {
					day.textColor = UIColor.lightGray
					self.isUserInteractionEnabled = false
				}else if curre == now {
					day.textColor = UIColor.red
					status.text = ""
					status.textColor = UIColor.red
					self.isUserInteractionEnabled = true
				}else {
//					day.textColor = UIColor.black
//					day.theme_textColor = [fnt_day,fnt_night]
					self.isUserInteractionEnabled = true
				}
			}
		}else {
			if startDay == currentDay {
				if endDay == currentDay {
					day.backgroundColor = selectColor
					day.textColor = UIColor.white
					status.text = "开始/截止"
					status.textColor = UIColor.white
				}else {
					day.backgroundColor = selectColor
					day.textColor = UIColor.white
					status.text = "开始"
					status.textColor = UIColor.white
				}
			}else {
				if endDay == currentDay {
					day.backgroundColor = selectColor
					day.textColor = UIColor.white
					status.text = "截止"
					status.textColor = UIColor.white
				}else {
					day.backgroundColor = normalColor
//					day.textColor = UIColor.black
//					day.theme_textColor = [fnt_day,fnt_night]
					status.text = ""
					day.backgroundColor = normalColor
					status.text = ""
					if curre > now {
						day.textColor = UIColor.lightGray
						self.isUserInteractionEnabled = false
					}else if curre == now {
						day.textColor = UIColor.red
						status.text = "今天"
						status.textColor = UIColor.red
						self.isUserInteractionEnabled = true
					}else {
//						day.textColor = UIColor.black
//						day.theme_textColor = [fnt_day,fnt_night]
						self.isUserInteractionEnabled = true
					}
				}
			}
			
			
			
			
			if type == CalendarItemType.circleAlone || type == CalendarItemType.squartAlone {
				return
			}
			if startDay.count == 0 || endDay.count == 0{
				return
			}
			let start = "\(startDay[0])\(startDay[1])\(startDay[2])"
			let ended = "\(endDay[0])\(endDay[1])\(endDay[2])"
			if (curre>start && curre<ended) || (curre<start && curre>ended){
				day.backgroundColor = middleColor
				day.textColor = UIColor.white
				status.text = ""
			}
		}
	}
	
	
	
	
	
	
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
