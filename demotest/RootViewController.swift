//
//  RootViewController.swift
//  demotest
//
//  Created by Phoenix on 2020/11/10.
//

import UIKit

import Charts

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        
        let tb = UITableView()
        tb.frame = self.view.bounds
        tb.delegate = self
        tb.dataSource = self
        self.view.addSubview(tb)
        
    }
    
    private lazy var titles: [String] = {
        return ["linear","easeInQuad","easeOutQuad","easeInOutQuad","easeInCubic","easeOutCubic","easeInOutCubic","easeInQuart","easeOutQuart","easeInOutQuart","easeInQuint","easeOutQuint","easeInOutQuint","easeInSine","easeOutSine","easeInOutSine","easeInExpo","easeOutExpo","easeInOutExpo","easeInCirc","easeOutCirc","easeInOutCirc","easeInElastic","easeOutElastic","easeInOutElastic","easeInBack","easeOutBack","easeInOutBack","easeInBounce","easeOutBounce","easeInOutBounce"]
    }()
    
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LineChartViewController()
        if indexPath.row == 0 {
            vc.mode = .linear
        }else if indexPath.row == 1 {
            vc.mode = .easeInQuad
        }else if indexPath.row == 2 {
            vc.mode = .easeOutQuad
        }else if indexPath.row == 3 {
            vc.mode = .easeInOutQuad
        }else if indexPath.row == 4 {
            vc.mode = .easeInCubic
        }else if indexPath.row == 5 {
            vc.mode = .easeOutCubic
        }else if indexPath.row == 6 {
            vc.mode = .easeInOutCubic
        }else if indexPath.row == 7 {
            vc.mode = .easeInQuart
        }else if indexPath.row == 8 {
            vc.mode = .easeOutQuart
        }else if indexPath.row == 9 {
            vc.mode = .easeInOutQuart
        }else if indexPath.row == 10 {
            vc.mode = .easeInQuint
        }else if indexPath.row == 11 {
            vc.mode = .easeOutQuint
        }else if indexPath.row == 12 {
            vc.mode = .easeInOutQuint
        }else if indexPath.row == 13 {
            vc.mode = .easeInSine
        }else if indexPath.row == 14 {
            vc.mode = .easeOutSine
        }else if indexPath.row == 15 {
            vc.mode = .easeInOutSine
        }else if indexPath.row == 16 {
            vc.mode = .easeInExpo
        }else if indexPath.row == 17 {
            vc.mode = .easeOutExpo
        }else if indexPath.row == 18 {
            vc.mode = .easeInOutExpo
        }else if indexPath.row == 19 {
            vc.mode = .easeInCirc
        }else if indexPath.row == 20 {
            vc.mode = .easeOutCirc
        }else if indexPath.row == 21 {
            vc.mode = .easeInOutCirc
        }else if indexPath.row == 22 {
            vc.mode = .easeInElastic
        }else if indexPath.row == 23 {
            vc.mode = .easeOutElastic
        }else if indexPath.row == 24 {
            vc.mode = .easeInOutElastic
        }else if indexPath.row == 25 {
            vc.mode = .easeInBack
        }else if indexPath.row == 26 {
            vc.mode = .easeOutBack
        }else if indexPath.row == 27 {
            vc.mode = .easeInOutBack
        }else if indexPath.row == 28 {
            vc.mode = .easeInBounce
        }else if indexPath.row == 29 {
            vc.mode = .easeOutBounce
        }else if indexPath.row == 30 {
            vc.mode = .easeInOutBounce
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


