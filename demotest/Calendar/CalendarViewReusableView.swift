//
//  CalendarViewReusableView.swift
//  Calendar
//
//  Created by 幻夏。 on 2019/1/23.
//  Copyright © 2019 郑谦. All rights reserved.
//

import UIKit

class CalendarViewReusableView: UICollectionReusableView {
	
	@IBOutlet weak var timeLabel: UILabel!
	
	private var headerMenu: CalendarMenuView!
	
	override func layoutSubviews() {
		if headerMenu != nil {
			headerMenu.frame = CGRect.init(x: 0, y: 30, width: bounds.width, height: 20)
		}
	}
	
	
	func showTimeWith(_ array: [String]) {

		timeLabel.text = "\(array[0])年\(array[1])月"

	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		timeLabel.font = UIFont.systemFont(ofSize: 16)
//		timeLabel.theme_textColor = [fnt_day,fnt_night]
		headerMenu = CalendarMenuView.init()
		addSubview(headerMenu)
		
    }

}
