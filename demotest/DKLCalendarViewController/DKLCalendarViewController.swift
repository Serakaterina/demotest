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
        
        contentView.delegate = self
        contentView.dataSource = self
        self.view.addSubview(contentView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let height = contentView.contentSize.height
        contentView.contentOffset = CGPoint(x: 0, y: height-kScreenH)
    }
    
    private lazy var contentView: DKLCalendarView = {
        let view = DKLCalendarView.initWith(CGRect(x: 0, y: 0, width: kScreenw, height: kScreenH))
        return view
    }()
    
    private let manager = DKLCalendarManager()
}

extension DKLCalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.days[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DKLCalendarCell.initWith(collectionView, indexPath: indexPath)
        cell.setTitle(manager.days[indexPath.section][indexPath.row])
        return cell
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
