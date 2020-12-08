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
        lb.textColor = DKLCalendarConfig.dayTextColor
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
        titleLabel.text = title
    }
}
