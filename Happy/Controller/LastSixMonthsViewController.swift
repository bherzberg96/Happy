//
//  LastSixMonthsViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 3/11/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import CoreData
import Charts

class LastSixMonthsViewController: UIViewController {
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let previousMonths = getPreviousMonths()
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let formato:BarChartFormatter = BarChartFormatter(previousMonths: previousMonths)
            let xaxis : XAxis = XAxis()
            
            let categories = try PersistenceService.context.fetch(fetchRequest)
            var dataSets : [LineChartDataSet] = [LineChartDataSet]()
            
            for category in Constants.allCategories {
                let cat = categories.first(where: {$0.name == category})
                
                var vals = getAveragesForCategory(cat: cat!)
                var yVals : [ChartDataEntry] = [ChartDataEntry]()
                
                for i in 1...Constants.previousMonthsCount {
                    if (vals[i-1] > 0) {
                        yVals.append(ChartDataEntry(x: Double(i-1), y: vals[i-1]))
                        //                        formato.stringForValue(Double(i), axis: xaxis)
                    }
                }
                
                let temp = categories.first(where: {$0.name == "mood"})!
                let novAvg = (temp.value(forKey: "firstMonthSum") as! Double)/(temp.value(forKey: "firstMonthCount") as! Double)
                let augAvg = (temp.value(forKey: "fourthMonthSum") as! Double)/(temp.value(forKey: "fourthMonthCount") as! Double)
                
                let color = Constants.categoryColors[category]!
                let set: LineChartDataSet = LineChartDataSet(values: yVals, label: category.capitalized)
                set.axisDependency = .left // Line will correlate with left axis values
                set.setColor(color.withAlphaComponent(0.5))
                set.setCircleColor(color)
                set.lineWidth = 2.0
                set.circleRadius = 6.0
                set.fillAlpha = 65 / 255.0
                set.fillColor = color
                set.drawCircleHoleEnabled = true
                
                dataSets.append(set)
            }
            
            xaxis.valueFormatter = formato
            
            let data: LineChartData = LineChartData(dataSets: dataSets)
            data.setDrawValues(false)
            
            lineChartView.data = data
            lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
            lineChartView.chartDescription?.text = ""
            lineChartView.doubleTapToZoomEnabled = false
            lineChartView.xAxis.setLabelCount(Constants.previousMonthsCount, force: true)
            //            lineChartView.leftAxis.axisMinimum = max(0.0, lineChartView.data!.yMin - 1.0)
            //            lineChartView.leftAxis.axisMaximum = min(10.0, lineChartView.data!.yMax + 1.0)
            lineChartView.leftAxis.axisMinimum = 1
            lineChartView.leftAxis.axisMaximum = 10
            lineChartView.leftAxis.labelCount = Int(lineChartView.leftAxis.axisMaximum - lineChartView.leftAxis.axisMinimum)
            lineChartView.rightAxis.enabled = false
        } catch { }
    }
    
    func getAveragesForCategory(cat: Category) -> [Double] {
        var avgArray = [Double]()
        
        for i in 1...Constants.previousMonthsCount {
            var place = ""
            switch i {
            case 4:
                place = "first"
            case 3:
                place = "second"
            case 2:
                place = "third"
            case 1:
                place = "fourth"
            default:
                place = "ERROR"
            }
            
            let sum = cat.value(forKey: "\(place)MonthSum") as! Double
            let count = cat.value(forKey: "\(place)MonthCount") as! Double
            
            var avg = 0.0
            if (count > 0.0) {
                avg = sum/count
            }
            avgArray.append(avg)
        }
        
        return avgArray
    }
    
    func getPreviousMonths() -> [Int] {
        let calendar = Calendar.current
        var dateComponents: DateComponents? = calendar.dateComponents([.hour, .minute, .second], from: Date())
        dateComponents?.year = 2020
        dateComponents?.month = 11
        dateComponents?.day = 28
        
        let now: Date = calendar.date(from: dateComponents!)!
//        let now = Date()
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        var month = Int(monthFormatter.string(from: now))!
        
        var array = [Int]()
        
        for _ in 1...Constants.previousMonthsCount {
            array.append(month)
            
            if (month > 0) {
                month -= 1
            } else {
                month = 12
            }
        }
        
        return array.reversed()
    }
}
