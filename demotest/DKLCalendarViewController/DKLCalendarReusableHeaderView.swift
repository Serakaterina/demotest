//
//  DKLCalendarReusableHeaderView.swift
//  demotest
//
//  Created by Serakaterina on 2020/12/8.
//

import UIKit

class DKLCalendarReusableHeaderView: UICollectionReusableView {
    
    class func initWith(_ cv: UICollectionView, indexPath: IndexPath) -> DKLCalendarReusableHeaderView {
        var header = cv.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DKLCalendarReusableHeaderView", for: indexPath) as? DKLCalendarReusableHeaderView
        if header == nil {
            header = DKLCalendarReusableHeaderView(frame: .zero)
        }
        return header!
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        print("DKLCalendarReusableHeaderView init")
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var leftTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = DKLCalendarConfig.headerYearMonthTextFont
        lb.textColor = DKLCalendarConfig.headerYearMonthTextColor
        return lb
    }()
}

extension DKLCalendarReusableHeaderView {
    private func setupUI() {
        self.addSubview(leftTitleLabel)
        leftTitleLabel.frame = CGRect(x: 16, y: 0, width: kScreenw-32, height: 40)
    }
}

extension DKLCalendarReusableHeaderView {
    func setTitle(_ title: String) {
        leftTitleLabel.text = title
    }
}
