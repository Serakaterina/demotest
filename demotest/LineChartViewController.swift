//
//  LineChartViewController.swift
//  demotest
//
//  Created by Phoenix on 2020/11/25.
//

import UIKit

import Charts

class LineChartViewController: UIViewController {
    
    var mode: ChartEasingOption = .easeInBack

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        
        
//        let lineChart = DKLLineChartView(frame: CGRect(x: 16, y: 64, width: 343, height: 178))
//
//        self.view.addSubview(lineChart)
//
//        lineChart.setData(6)
        
        let circleChart = DKLCircleChartView(frame: CGRect(x: 0, y: 100, width: 200, height: 200))
        
        circleChart.backgroundColor = UIColor.white
        
        self.view.addSubview(circleChart)
        
        circleChart.setData()
    }
    
    deinit {
        
        
        
    }

}
