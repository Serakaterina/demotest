//
//  DKLLineChartView.swift
//  demotest
//
//  Created by Phoenix on 2020/11/25.
//

import UIKit

import Charts

/// 横竖轴 标签字体色
private let xyAxisLabelTextColor = UIColor(red: 119/255.0, green: 119/255.0, blue: 119/255.0, alpha: 1)

/// 竖轴网格线颜色
private let verticalGridLineColor = UIColor.clear

/// 竖轴边框线颜色
private let verticalAxisLineColor = UIColor.clear

/// 横轴网格线颜色
private let horizontalGridLineColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1)

/// 横轴边框线颜色
private let horizontalAxisLineColor = UIColor.clear

/// 竖轴高亮线颜色
private let highlightLineColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1)

private let lineColor = UIColor(red: 7/255.0, green: 192/255.0, blue: 194/255.0, alpha: 1)

@objc class DKLLineChartView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 6
        self.setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        chartView.frame = self.bounds
    }
    
    /// Y轴最大值
    private var yAxisMaximum: Double = 0 {
        didSet {
            self.chartView.leftAxis.axisMaximum = yAxisMaximum
        }
    }
    
    /// X轴 标题个数
    private var xAxisLabelCount: Int = 0 {
        didSet {
            self.chartView.xAxis.labelCount = xAxisLabelCount
//            self.chartView.xAxis.forceLabelsEnabled = true
        }
    }
    
    private lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.noDataText = "暂无数据"
        chartView.noDataTextColor = xyAxisLabelTextColor
        chartView.noDataFont = UIFont.systemFont(ofSize: 10)
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.legend.form = .none
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.gridColor = verticalGridLineColor
        chartView.xAxis.axisLineColor = horizontalAxisLineColor
        chartView.xAxis.labelTextColor = xyAxisLabelTextColor
        chartView.rightAxis.enabled = false
        chartView.leftAxis.axisMinimum = 0
//        chartView.leftAxis.labelCount = 6
        chartView.leftAxis.forceLabelsEnabled = true
        chartView.leftAxis.axisLineColor = verticalAxisLineColor
        chartView.leftAxis.gridLineDashLengths = [2.0]
        chartView.leftAxis.gridColor = horizontalGridLineColor
        chartView.leftAxis.gridAntialiasEnabled = true
        chartView.leftAxis.labelTextColor = xyAxisLabelTextColor
        chartView.extraLeftOffset = 10
        chartView.extraRightOffset = 30
        chartView.extraTopOffset = 20
        return chartView
    }()
    
    var xData: [String] = []
    
    var yData: [ChartDataEntry] = []
    
}

extension DKLLineChartView {
    
    private func setupUI() {
        
        self.addSubview(chartView)
        
    }
    
}

extension DKLLineChartView: IAxisValueFormatter {
    
    /// 设置折线图的数据
    /// - Parameters:
    ///   - xAxisValues: X坐标轴数据
    ///   - yAxisValues: Y坐标轴数据
    ///   - yAxisMaximum: Y坐标轴比例尺最大值
    @objc func setData(_ yAxisMaximum: Double) {
        
        
        
        for i in 0..<14 {
            let num = arc4random()%100+1
            let entry = ChartDataEntry(x: Double(i), y: Double(num))
            xData.append("\(i)")
            yData.append(entry)
            
            print("x:\(i), y:\(num)")
        }
        
        self.chartView.xAxis.labelCount = 14
        
        self.chartView.xAxis.forceLabelsEnabled = true
        
        self.chartView.xAxis.valueFormatter = self
        
        let set = LineChartDataSet.init(entries: yData, label: nil);
        
        set.colors = [lineColor]

        set.drawCirclesEnabled = false
        
        set.lineWidth = 2.0;
        
        set.mode = .horizontalBezier
        
        set.drawValuesEnabled = true
        
        set.highlightColor = highlightLineColor
        
//        set.drawHorizontalHighlightIndicatorEnabled = false
        
        chartView.data = LineChartData(dataSet: set)
        
        self.chartView.xAxis.labelCount = 7
        
        self.chartView.xAxis.forceLabelsEnabled = true
        
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBack)
        
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let tmp = self.xData[Int(floor(value))]
        print(value, tmp)
        return tmp
    }
    
}

