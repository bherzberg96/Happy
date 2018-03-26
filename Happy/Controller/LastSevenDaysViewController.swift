//
//  LastSevenDaysViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 3/11/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import CoreData
import Charts

class LastSevenDaysViewController: UIViewController {
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = Calendar.current
        var dateComponents: DateComponents? = calendar.dateComponents([.hour, .minute, .second], from: Date())
        dateComponents?.year = 2020
        dateComponents?.month = 11
        dateComponents?.day = 28
        
        let now: Date = calendar.date(from: dateComponents!)!
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Entry.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            let entries = try PersistenceService.context.fetch(fetchRequest)
            
            var lastSevenDateEntries = [Entry]()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            
            for i in 1...7 {
                let date = Calendar.current.date(byAdding: .day, value: -i, to: now)!
                let dateEntry = entries.first(where: {dateFormatter.string(from: $0.date!) == dateFormatter.string(from: date)})
                lastSevenDateEntries.append(dateEntry!) // need to remove ! later; if no entry was logged for a given date, it will throw an exception
            }
            
            let formato:BarChartFormatter = BarChartFormatter(previousEntries: lastSevenDateEntries)
            let xaxis:XAxis = XAxis()
            
            var dataSets : [LineChartDataSet] = [LineChartDataSet]()
            
            for category in Constants.allCategories {
                var vals = [Double]()
                for entry in lastSevenDateEntries {
                    vals.append(entry.value(forKey: category) as! Double)
                }
                
                var yVals : [ChartDataEntry] = [ChartDataEntry]()
                
                for i in 0...6 {
                    if (vals[i] > 0) {
                        yVals.append(ChartDataEntry(x: Double(i), y: vals[i]))
                        //                        formato.stringForValue(Double(i), axis: xaxis)
                    }
                }
                
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
            lineChartView.xAxis.setLabelCount(7, force: true)
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
        
        for i in 1...4 {
            var place = ""
            switch i {
            case 1:
                place = "first"
            case 2:
                place = "second"
            case 3:
                place = "third"
            case 4:
                place = "fourth"
            default:
                place = "ERROR"
            }
            
            let sum = cat.value(forKey: "\(place)MonthSum") as! Double
            let count = cat.value(forKey: "\(place)MonthCount") as! Double
            
            let avg = sum/count
            avgArray.append(avg)
        }
        
        return avgArray
    }
    
    func getPreviousMonths() -> [Int] {
        // Get last six months
        let calendar = Calendar.current
        var dateComponents: DateComponents? = calendar.dateComponents([.hour, .minute, .second], from: Date())
        dateComponents?.year = 2020
        dateComponents?.month = 11
        dateComponents?.day = 28
        
        let now: Date = calendar.date(from: dateComponents!)!
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        var month = Int(monthFormatter.string(from: now))!
        
        var array = [Int]()
        
        for _ in 0...3 {
            array.append(month)
            
            if (month > 0) {
                month -= 1
            } else {
                month = 12
            }
        }
        
        return array
    }
}
