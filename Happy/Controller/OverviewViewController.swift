//
//  OverviewViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import CoreData

class OverviewViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteOldData()
        createCategoryCoreData()
        populateWithFakeData(limit: Constants.fakeDates.count)
    }
    
    func createCategoryCoreData() {
        for category in Constants.allCategories {
            let newCoreDataCategory = Category(context: PersistenceService.context)
            newCoreDataCategory.setValue(category, forKey: "name")
            PersistenceService.saveContext()
        }
    }
    
    func populateWithFakeData(limit : Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        var i = 0
        
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let month = monthFormatter.string(from: formatter.date(from: Constants.fakeDates[limit-1])!)
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let year = yearFormatter.string(from: formatter.date(from: Constants.fakeDates[limit-1])!)
        
        let previousMonths = getPreviousMonths(numberOfMonths: Constants.previousMonthsCount, month: month, year: year)
        
        while i < limit {
            
            do {
                let coreDataCategories = try PersistenceService.context.fetch(categoryFetchRequest)
                
                let date = formatter.date(from: Constants.fakeDates[i])
                let coreDataEntry = Entry(context: PersistenceService.context)
                coreDataEntry.setValue(date, forKey: "date")
                for category in Constants.allCategories {
                    let randomInt = arc4random_uniform(9)+1
                    coreDataEntry.setValue(randomInt, forKey: category)
                }
                coreDataEntry.setValue("Blah blah blah", forKey: "notes")
                PersistenceService.saveContext()
                
                let yearAndMonthFormatter = DateFormatter()
                yearAndMonthFormatter.dateFormat = "yyyy/MM"
                let yearAndMonth = yearAndMonthFormatter.string(from: date!)
                
                for category in Constants.allCategories {
                    for coreDataCategory in coreDataCategories {
                        var x = "\(coreDataCategory.value(forKey: "name")!)"
                        if ("\(coreDataCategory.value(forKey: "name")!)" == category) {
                            for previousMonth in previousMonths {
                                if (previousMonth == yearAndMonth) {
                                    let val = getVal(previousMonths: previousMonths, yearAndMonth: yearAndMonth)
                                    if let nonNilVal = val {
                                        print("\(nonNilVal)")
                                        print("\(coreDataCategory.value(forKey: "\(nonNilVal)Sum"))")
                                        print("\(coreDataEntry.value(forKey: category) as! Int)")
                                        // sum
                                        coreDataCategory.setValue((coreDataCategory.value(forKey: "\(nonNilVal)Sum") as! Int) + (coreDataEntry.value(forKey: category) as! Int), forKey: "\(nonNilVal)Sum")
                                    
                                        //count
                                        coreDataCategory.setValue((coreDataCategory.value(forKey: "\(nonNilVal)Count") as! Int) + 1, forKey: "\(nonNilVal)Count")
                                    }
                                }
                            }
                            
                            coreDataCategory.setValue((coreDataCategory.value(forKey: "sum") as! Int) + (coreDataEntry.value(forKey: category) as! Int), forKey: "sum")
                            coreDataCategory.setValue(coreDataCategory.value(forKey: "count") as! Int + 1, forKey: "count")
                        }
                    }
                }
                
                PersistenceService.saveContext()
                
                i += 1
            } catch { }
        }
        
        do {
            let coreDataCategories = try PersistenceService.context.fetch(categoryFetchRequest)
            
            for coreDataCategory in coreDataCategories {
                print("\(coreDataCategory.value(forKey: "name"))")
                print("Sum: \(coreDataCategory.value(forKey: "sum"))")
                print("Count: \(coreDataCategory.value(forKey: "count"))")
                print("First month sum: \(coreDataCategory.value(forKey: "firstMonthSum"))")
                print("First month count: \(coreDataCategory.value(forKey: "firstMonthCount"))")
                print("Second month sum: \(coreDataCategory.value(forKey: "secondMonthSum"))")
                print("Second month count: \(coreDataCategory.value(forKey: "secondMonthCount"))")
                print("_______")
            }
        } catch { }
        
    }
    
    func getVal(previousMonths: [String], yearAndMonth: String) -> String? {
        var i = 0
        for previousMonth in previousMonths {
            if (previousMonth == yearAndMonth) {
                switch i+1 {
                case 1:
                    return "firstMonth"
                case 2:
                    return "secondMonth"
                case 3:
                    return "thirdMonth"
                case 4:
                    return "fourthMonth"
                default:
                    return nil
                }
            }
            i += 1
        }
        
        return nil
    }
    
    func deleteOldData() {
        let entryFetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let coreDataEntires = try PersistenceService.context.fetch(entryFetchRequest)
            for entry in coreDataEntires {
                PersistenceService.context.delete(entry)
            }
            
            let coreDataCategories = try PersistenceService.context.fetch(categoryFetchRequest)
            for category in coreDataCategories {
                PersistenceService.context.delete(category)
            }
            
            PersistenceService.saveContext()
        } catch { }
    }
    
    func getPreviousMonths(numberOfMonths: Int, month: String, year: String) -> [String] {
        //        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
        var year = Int(year)!
        var updatedArray = [String]()
        
        var whileLoopCount = 0
        var arrayIndex = Int(month)!-1
        while whileLoopCount < numberOfMonths {
            updatedArray.append("\(year)/\(months[arrayIndex])")
            
            if (arrayIndex > 0) {
                arrayIndex -= 1
            } else {
                arrayIndex = months.count-1
                year -= 1
            }
            whileLoopCount += 1
        }
        
        return updatedArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
