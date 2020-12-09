//
//  DKLCalendarViewController.swift
//  demotest
//
//  Created by Serakaterina on 2020/12/8.
//

import UIKit

class DKLCalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = DKLCalendarConfig.backgroundColor
        
        self.view.addSubview(menuView)
        
        contentView.delegate = self
        contentView.dataSource = self
        self.view.addSubview(contentView)
        
        let nowY = String(format: "%ld", manager.endDate.year)
        let nowM = String(format: "%02d", manager.endDate.month)
        let nowD = String(format: "%02d", manager.endDate.day)
        self.nowDateString = [nowY, nowM, nowD]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let height = contentView.contentSize.height
        contentView.contentOffset = CGPoint(x: 0, y: height-kScreenH)
    }
    
    private lazy var contentView: DKLCalendarView = {
        let view = DKLCalendarView.initWith(CGRect(x: 0, y: 64+32, width: kScreenw, height: kScreenH-64-32))
        return view
    }()
    
    private lazy var menuView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 64, width: kScreenw, height: 32))
        view.backgroundColor = UIColor.white
        let titles = ["日","一","二","三","四","五","六"]
        let labelSize = CGSize(width: (kScreenw-32)/7, height: 32)
        for i in 0..<titles.count {
            let lb = UILabel()
            lb.text = titles[i]
            lb.font = UIFont.systemFont(ofSize: 12)
            lb.textColor = DKLCalendarConfig.dayTextColor
            lb.textAlignment = .center
            lb.frame = CGRect(x: CGFloat(i)*labelSize.width+16, y: 0, width: labelSize.width, height: labelSize.height)
            view.addSubview(lb)
        }
        return view
    }()
    
    private let manager = DKLCalendarManager()
    
    private var startDate: [String]!
    
    private var endDate: [String]!
    
    private var nowDateString:[String]!
}

extension DKLCalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.GetTotalItemsIn(section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DKLCalendarCell.initWith(collectionView, indexPath: indexPath)
        
        let dateTime = manager.GetEarlierAndLaterDaysFrom(date: manager.endDate, andMonth: indexPath.section)
        
        let dayIndex = indexPath.row-(manager.GetStartDayInSection(dateTime) as NSString).integerValue+1
        
        let cellTextString = dayIndex > 0 ? "\(dayIndex)" : ""
        
        cell.setTitle(cellTextString)
    
        let year = "\(manager.GetYear(dateTime))"
        
        let month = String(format: "%02d", dateTime.month)

        let day = String(format: "%02d", dayIndex)
        
        let current = [year, month, day]
        
        cell.reloadCellWith(self.startDate ?? [], current, self.endDate ?? [], self.nowDateString!)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dateTime = manager.GetEarlierAndLaterDaysFrom(date: manager.endDate, andMonth: indexPath.section)
        
        let dayIndex = indexPath.row-manager.GetStartDayInSection(dateTime).intValue+1
        
        let comp = manager.GetCurrentComponentsWith(date: dateTime)
        
        let selectY = "\(comp.year!)"
        
        let selectM = String(format: "%02d", comp.month!)
        
        
        let selectD = String(format: "%02d", dayIndex)
        
        if startDate == nil {
            startDate = [selectY, selectM, selectD]
            self.contentView.reloadData()
        }else {
            if endDate == nil {
                /// 此处为开始日期不为空, 然后点击的日期为截止时间, 这个时候表明选中了一段日期, 则返回
                endDate = [selectY, selectM, selectD]
                self.contentView.reloadData()
            }else {
                /// 开始/结束日期都不为空, 那么证明已经选择过一段时间, 需要先全部清空然后给开始q日期赋值
                startDate = nil
                endDate = nil
                startDate = [selectY, selectM, selectD]
                self.contentView.reloadData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = DKLCalendarReusableHeaderView.initWith(collectionView, indexPath: indexPath)
            header.setTitle(manager.sections[indexPath.section])
            return header
        }
        return UICollectionReusableView()
    }
    
    
}
