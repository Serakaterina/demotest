//
//  DKLCircleChartView.swift
//  demotest
//
//  Created by Serakaterina on 2020/12/3.
//

import UIKit

import Charts

class DKLCircleChartView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var chartView: PieChartView = {
        let chart = PieChartView()
        chart.backgroundColor = UIColor.orange
        chart.holeColor = UIColor.clear
        chart.holeRadiusPercent = 0.8
//        chart.transparentCircleRadiusPercent = 0.1
//        chart.rotationEnabled = false
//        chart.highlightPerTapEnabled = false
//        chart.chartDescription?.enabled = false
        chart.legend.enabled = false
//        chart.drawCenterTextEnabled = false
//        chart.legend.form = .none
        chart.centerText = "¥320.00"
//        chart.setExtraOffsets(left: -18, top: -18, right: -18, bottom: -18)
        return chart
    }()
}

extension DKLCircleChartView {
    
    private func setupUI() {
        
        chartView.frame = self.bounds
        
        self.addSubview(chartView)
        
    }
    
}

extension DKLCircleChartView {
    func setData() {
        let count = 3
        var yValues: [PieChartDataEntry] = []
        for _ in 0..<count {
            let random = Double(arc4random()%100 + 1)
            let data = PieChartDataEntry(value: random, label: nil)
            yValues.append(data)
        }
        let dateSet = PieChartDataSet(entries: yValues, label: nil)
        /// 是否显示数据
        dateSet.drawValuesEnabled = false
        dateSet.sliceSpace = 3
        let data = PieChartData(dataSet: dateSet)
        chartView.data = data
//        chartView.animate(xAxisDuration: 1.0, easingOption: .easeInBack)
        /*
             NSMutableArray *colors = [[NSMutableArray alloc] init];
             [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
             [colors addObjectsFromArray:ChartColorTemplates.joyful];
             [colors addObjectsFromArray:ChartColorTemplates.colorful];
             [colors addObjectsFromArray:ChartColorTemplates.liberty];
             [colors addObjectsFromArray:ChartColorTemplates.pastel];
             [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
             dataSet.colors = colors;//区块颜色
             dataSet.sliceSpace = 0;//相邻区块之间的间距
             dataSet.selectionShift = 8;//选中区块时, 放大的半径
             dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
             dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
             //数据与区块之间的用于指示的折线样式
             dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
             dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
             dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
             dataSet.valueLineWidth = 1;//折线的粗细
             dataSet.valueLineColor = [UIColor brownColor];//折线颜色
             
             //data
             PieChartData *data = [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
             NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
             formatter.numberStyle = NSNumberFormatterPercentStyle;
             formatter.maximumFractionDigits = 0;//小数位数
             formatter.multiplier = @1.f;
             [data setValueFormatter:formatter];//设置显示数据格式
             [data setValueTextColor:[UIColor brownColor]];
             [data setValueFont:[UIFont systemFontOfSize:10]];
         */
    }
}
