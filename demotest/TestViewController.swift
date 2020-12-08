//
//  TestViewController.swift
//  demotest
//
//  Created by Phoenix on 2020/11/25.
//

import UIKit

class TestViewController: UIViewController {
    
//    var mode: DKLDatePickerMode = .yearMonthDayHourMinuteSecond
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "时间选择器"
        
        self.view.backgroundColor = UIColor.lightGray

        let tb = UITableView()

        tb.frame = self.view.bounds

        tb.delegate = self

        tb.dataSource = self

        self.view.addSubview(tb)
        
    }

    private lazy var titles: [String] = {
        return ["年-月-日 时:分:秒","年-月-日 时:分","年-月-日","年-月","时:分:秒","时:分"]
    }()

    private lazy var formatters: [String] = {
       return ["yyyy-MM-dd HH:mm:ss","yyyy-MM-dd HH:mm","yyyy-MM-dd","yyyy-MM","HH:mm:ss","HH:mm"]
    }()

    private var visiableCells: [UITableViewCell] = []

    private var tmpDate: Date?

}


extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "PickerCell")
        }
        cell?.textLabel?.text = titles[indexPath.row]
        visiableCells.append(cell!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            self.showWithMode(.yearMonthDayHourMinuteSecond, index: indexPath.row)
//        }else if indexPath.row == 1 {
//            self.showWithMode(.yearMonthDayHourMinute, index: indexPath.row)
//        }else if indexPath.row == 2 {
//            self.showWithMode(.yearMonthDay, index: indexPath.row)
//        }else if indexPath.row == 3 {
//            self.showWithMode(.yearMonth, index: indexPath.row)
//        }else if indexPath.row == 4 {
//            self.showWithMode(.hourMinuteSecond, index: indexPath.row)
//        }else if indexPath.row == 5 {
//            self.showWithMode(.hourMinute, index: indexPath.row)
//        }
    }
    
//    private func showWithMode(_ mode: DKLDatePickerMode, index: Int) {
//        let manager = DKLDatePickerManager()
//        manager.pickerMode = mode
//        manager.unitMode = .fixed
//        manager.unitTextColor = UIColor.red
//        manager.titleLabelText = "请选择开始时间"
//        manager.isOpenDateJudgement = true
//        manager.isDismissWhenSelectFailure = false
//        let picker = DKLDatePickerView.initWithManager(manager) { [weak self](date) in
//            guard let weakSelf = self else { return }
//            weakSelf.visiableCells[index].textLabel?.text = date.dklDate_DateStringWithFormatter(weakSelf.formatters[index])
//            weakSelf.tmpDate = date
//        } failureBlock: {
//            dklDate_DEBUGLOG("时间选择错误啦!!!")
//        }
//        picker.show()
//    }
    
}
