//
//  LastTwelveMonthsViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 3/11/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import Charts

class LastTwelveMonthsViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let nameOfMonth = dateFormatter.string(from: now)
        
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
//        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        setChart(dataPoints: months, values: unitsSold)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
//        let formato:BarChartFormatter = BarChartFormatter()
//        let xaxis:XAxis = XAxis()
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
//            formato.stringForValue(Double(i), axis: xaxis)
        }
//        xaxis.valueFormatter = formato
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChartView.xAxis.granularityEnabled = true
        barChartView.xAxis.labelCount = 6
        
        barChartView.data = chartData
        
//        barChartView.xAxis.valueFormatter = xaxis.valueFormatter
    }
}
