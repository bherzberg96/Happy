import UIKit
import Foundation
import Charts

@objc(ChartFormatter)
public class ChartFormatter: NSObject, IAxisValueFormatter{
    
    var vals = [String]()
    
    init(previousMonths: [Int]) {
        super.init()
        vals = convertMonthFormats(months: previousMonths)
    }
    
    init(previousEntries: [Entry]) {
        super.init()
        vals = convertDayFormats(entries: previousEntries)
    }
    
    func convertDayFormats(entries: [Entry]) -> [String] {
        var daysOfWeek = [String]()
        
        for entry in entries {
            let date = entry.date!
            
            let dayOfWeekFormatter = DateFormatter()
            dayOfWeekFormatter.dateFormat = "EEE"
            let dayOfWeek = dayOfWeekFormatter.string(from: date)
            daysOfWeek.append(dayOfWeek)
        }
        
        return daysOfWeek
    }
    
    func convertMonthFormats(months: [Int]) -> [String] {
        var returnArray = [String]()
        
        for month in months {
            switch month {
                case 1:
                    returnArray.append("Jan")
                case 2:
                    returnArray.append("Feb")
                case 3:
                    returnArray.append("Mar")
                case 4:
                    returnArray.append("Apr")
                case 5:
                    returnArray.append("May")
                case 6:
                    returnArray.append("Jun")
                case 7:
                    returnArray.append("Jul")
                case 8:
                    returnArray.append("Aug")
                case 9:
                    returnArray.append("Sep")
                case 10:
                    returnArray.append("Oct")
                case 11:
                    returnArray.append("Nov")
                case 12:
                    returnArray.append("Dec")
                default:
                    returnArray.append("???")
            }
        }
        
        return returnArray
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        if (value <= 3) {
        return vals[Int(value)]
//        } else {
//            return "WTF"
//        }
    }
}
