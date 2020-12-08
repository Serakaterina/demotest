//
//  CalendarMenuView.swift
//  Calendar
//
//  Created by 幻夏。 on 2019/1/23.
//  Copyright © 2019 郑谦. All rights reserved.
//

import UIKit

class CalendarMenuView: UIView {

	private var labels: [UILabel] = []
	
	private let titles:[String] = ["周日","周一","周二","周三","周四","周五","周六"]
	
	convenience init() {
		self.init(frame: .zero)
		
		for i in 0..<titles.count {
			let lb = UILabel()
			lb.text = titles[i]
			lb.textAlignment = .center
			lb.font = UIFont.systemFont(ofSize: 12)
			addSubview(lb)
			labels.append(lb)
		}
	}
	
	override func layoutSubviews() {
		let lb_w = bounds.width/CGFloat(labels.count)
		for i in 0..<labels.count {
			labels[i].frame = CGRect.init(x: CGFloat(i)*lb_w, y: 0, width: lb_w, height: bounds.height)
		}
	}

	private override init(frame: CGRect) {
		super.init(frame: frame)
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
