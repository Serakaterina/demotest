//
//  DKLCalendarCell.swift
//  demotest
//
//  Created by Serakaterina on 2020/12/8.
//

import UIKit

private let cellid = "DKLCalendarCell"

class DKLCalendarCell: UICollectionViewCell {
    
    class func initWith(_ cv: UICollectionView, indexPath: IndexPath) -> DKLCalendarCell {
        var cell = cv.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as? DKLCalendarCell
        if cell == nil {
            cell = DKLCalendarCell(frame: .zero)
        }
        return cell!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var baseView: UIView = {
        return UIView()
    }()
    
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = DKLCalendarConfig.dayTextFont
//        lb.textColor = DKLCalendarConfig.dayTextColor
        lb.textColor = UIColor.blue
        lb.layer.cornerRadius = 2
        return lb
    }()
}

extension DKLCalendarCell {
    private func setupUI() {
        baseView.frame = self.bounds
        self.addSubview(baseView)
        titleLabel.frame = CGRect(x: (self.frame.size.width-32)/2, y: 0, width: 32, height: 32)
        baseView.addSubview(titleLabel)
    }
}

extension DKLCalendarCell {
    func setTitle(_ title: String) {
        if title.length == 0 || title == "" {
            self.isHidden = true
        }else {
            self.isHidden = false
        }
        titleLabel.text = title
    }
    func reloadCellWith(_ startDay: [String],
                        _ currentDay: [String],
                        _ endDay: [String],
                        _ nowDay: [String])
    {
//        print("startDay: \(startDay); currentDay: \(currentDay); endDay: \(endDay); nowDay: \(nowDay)")
        
//        if currentDay[2].intValue > 0 {
//            self.isHidden = false
//        }else {
//            self.isHidden = true
//        }
        
        let current = "\(currentDay[0])\(currentDay[1])\(currentDay[2])"
        
        let now = "\(nowDay[0])\(nowDay[1])\(nowDay[2])"
        
        if startDay.count == 0 {
            baseView.backgroundColor = DKLCalendarConfig.backgroundColor
            if current > now {
                titleLabel.textColor = DKLCalendarConfig.dayUnselectColor
                self.isUserInteractionEnabled = false
            }else if current == now {
                titleLabel.textColor = UIColor.red
                self.isUserInteractionEnabled = true
            }else {
                titleLabel.textColor = DKLCalendarConfig.dayTextColor
                self.isUserInteractionEnabled = true
            }
        }else if endDay.count == 0 {
            if startDay == endDay {
                titleLabel.backgroundColor = DKLCalendarConfig.backgroundColor
                if current > now {
                    titleLabel.textColor = DKLCalendarConfig.dayUnselectColor
                    self.isUserInteractionEnabled = false
                }else if current == now {
                    titleLabel.textColor = UIColor.red
                    self.isUserInteractionEnabled = true
                }else {
                    titleLabel.textColor = DKLCalendarConfig.dayTextColor
                    self.isUserInteractionEnabled = true
                }
            }else if startDay == currentDay {
                titleLabel.backgroundColor = DKLCalendarConfig.daySelectBackColor
                titleLabel.textColor = DKLCalendarConfig.daySelectTextColor
            }else {
                titleLabel.backgroundColor = DKLCalendarConfig.backgroundColor
                if current > now {
                    titleLabel.textColor = DKLCalendarConfig.dayUnselectColor
                    self.isUserInteractionEnabled = false
                }else if current == now {
                    titleLabel.textColor = UIColor.red
                    self.isUserInteractionEnabled = true
                }else {
                    titleLabel.textColor = DKLCalendarConfig.dayTextColor
                    self.isUserInteractionEnabled = true
                }
            }
        }else {
            if startDay == currentDay {
                if endDay == currentDay {
//                    day.backgroundColor = selectColor
//                    day.textColor = UIColor.white
//                    status.text = "开始/截止"
//                    status.textColor = UIColor.white
                }else {
//                    day.backgroundColor = selectColor
//                    day.textColor = UIColor.white
//                    status.text = "开始"
//                    status.textColor = UIColor.white
                }
            }else {
                if endDay == currentDay {
//                    day.backgroundColor = selectColor
//                    day.textColor = UIColor.white
//                    status.text = "截止"
//                    status.textColor = UIColor.white
                }else {
//                    day.backgroundColor = normalColor
//                    day.textColor = UIColor.black
//                    day.theme_textColor = [fnt_day,fnt_night]
//                    status.text = ""
//                    day.backgroundColor = normalColor
//                    status.text = ""
                    if current > now {
//                        day.textColor = UIColor.lightGray
//                        self.isUserInteractionEnabled = false
                    }else if current == now {
//                        day.textColor = UIColor.red
//                        status.text = "今天"
//                        status.textColor = UIColor.red
//                        self.isUserInteractionEnabled = true
                    }else {
//                        day.textColor = UIColor.black
//                        day.theme_textColor = [fnt_day,fnt_night]
//                        self.isUserInteractionEnabled = true
                    }
                }
            }
            
            
            
            
//            if type == CalendarItemType.circleAlone || type == CalendarItemType.squartAlone {
//                return
//            }
//            if startDay.count == 0 || endDay.count == 0{
//                return
//            }
//            let start = "\(startDay[0])\(startDay[1])\(startDay[2])"
//            let ended = "\(endDay[0])\(endDay[1])\(endDay[2])"
//            if (curre>start && curre<ended) || (curre<start && curre>ended){
//                day.backgroundColor = middleColor
//                day.textColor = UIColor.white
//                status.text = ""
//            }
        }
    }
}

extension String {
    public var length: Int {
        return (self as NSString).integerValue
    }
}
