//
//  AveragesViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 3/11/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import CoreData
import Charts

class AveragesViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let categories = try PersistenceService.context.fetch(fetchRequest)
            
//            let formato:BarChartFormatter = BarChartFormatter(previousEntries: lastSevenDateEntries)
//            let xaxis:XAxis = XAxis()
            
            var dataSets : [BarChartDataSet] = [BarChartDataSet]()
            
            var i = 1
            for category in categories {
                let sum = category.value(forKey: "sum") as! Double
                let count = category.value(forKey: "count") as! Double
                let avg = sum/count
                
                var yVals : [BarChartDataEntry] = [BarChartDataEntry]()
                
                yVals.append(BarChartDataEntry(x: Double(i), y: avg))
                        
                let color = Constants.categoryColors[category.name!]!
                let set: BarChartDataSet = BarChartDataSet(values: yVals, label: category.name!.capitalized)
                set.axisDependency = .left // Line will correlate with left axis values
                set.setColor(color.withAlphaComponent(0.5))
                
                dataSets.append(set)
                i += 1
            }
            
//            xaxis.valueFormatter = formato
            
            let data: BarChartData = BarChartData(dataSets: dataSets)
            data.setDrawValues(false)
            
            barChartView.data = data
//            barChartView.xAxis.valueFormatter = xaxis.valueFormatter
            barChartView.chartDescription?.text = ""
            barChartView.doubleTapToZoomEnabled = false
            barChartView.xAxis.setLabelCount(7, force: true)
            //            lineChartView.leftAxis.axisMinimum = max(0.0, lineChartView.data!.yMin - 1.0)
            //            lineChartView.leftAxis.axisMaximum = min(10.0, lineChartView.data!.yMax + 1.0)
            barChartView.leftAxis.axisMinimum = 1
            barChartView.leftAxis.axisMaximum = 10
            barChartView.leftAxis.labelCount = Int(barChartView.leftAxis.axisMaximum - barChartView.leftAxis.axisMinimum)
            barChartView.rightAxis.enabled = false
        } catch { }
    }
}
