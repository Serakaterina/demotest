//
//  DKLCalendarView.swift
//  demotest
//
//  Created by Serakaterina on 2020/12/8.
//

import UIKit

let kScreenw = UIScreen.main.bounds.size.width

let kScreenH = UIScreen.main.bounds.size.height

class DKLCalendarView: UICollectionView {
    
    class func initWith(_ frame: CGRect) -> DKLCalendarView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenw-32)/7, height: 32)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: kScreenw, height: 40)
        layout.footerReferenceSize = CGSize.zero
        let view = DKLCalendarView(frame: frame, collectionViewLayout: layout)
        view.register(DKLCalendarCell.self, forCellWithReuseIdentifier: "DKLCalendarCell")
        view.register(DKLCalendarReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DKLCalendarReusableHeaderView")
        return view
    }

    private override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
