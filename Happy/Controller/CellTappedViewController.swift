//
//  CellTappedViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 3/3/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import CoreData

struct EntryStruct {
    let key: String
    let value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

class CellTappedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var entry = [EntryStruct]()
    var coreDataEntry = Entry()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowEntry = entry[indexPath.row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "category")
        cell.textLabel?.text = "\(rowEntry.key.capitalized): \(rowEntry.value)"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataEntry = entries[myIndex]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY"
//        entry.updateValue(dateFormatter.string(from: coreDataEntry.date!), forKey: "date")
        entry.append(EntryStruct(key: "date", value: dateFormatter.string(from: coreDataEntry.date!)))
        
        for category in Constants.allCategories {
            if let entryVal = coreDataEntry.value(forKey: category) {
                entry.append(EntryStruct(key: category, value: "\(entryVal)"))
            }
        }
        var notesVal = ""
        if coreDataEntry.value(forKey: "notes") != nil {
            notesVal = coreDataEntry.value(forKey: "notes") as! String
        }
        entry.append(EntryStruct(key: "notes", value: "\(notesVal)"))
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        if(self.tableView.isEditing == true)
        {
            self.tableView.isEditing = false
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
        else
        {
            self.tableView.isEditing = true
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        let date = coreDataEntry.date
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let yearAndMonthFormatter = DateFormatter()
            yearAndMonthFormatter.dateFormat = "yyyy/MM"
            let yearAndMonth = yearAndMonthFormatter.string(from: date!)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MM"
            let month = monthFormatter.string(from: Date())
            
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            let year = yearFormatter.string(from: Date())
            
            let previousMonths = getPreviousMonths(numberOfMonths: 4, month: month, year: year)
            
            let coreDataCategories = try PersistenceService.context.fetch(fetchRequest)
            for category in Constants.allCategories {
                let coreDataCategory = coreDataCategories.first(where: {$0.name == category})!
                for previousMonth in previousMonths {
                    if (previousMonth == yearAndMonth) {
                        let val = getVal(previousMonths: previousMonths, yearAndMonth: yearAndMonth)
                        if let nonNilVal = val {
                            print("Val: \(nonNilVal)")
                            print("Sum: \(coreDataCategory.value(forKey: "\(nonNilVal)Sum"))")
                            //                            print("\(coreDataEntry.value(forKey: category) as! Int)")
                            
                            if let coreDataEntryVal = coreDataEntry.value(forKey: category) {
                                // sum
                                coreDataCategory.setValue((coreDataCategory.value(forKey: "\(nonNilVal)Sum") as! Int) - (coreDataEntryVal as! Int), forKey: "\(nonNilVal)Sum")
                                
                                //count
                                coreDataCategory.setValue((coreDataCategory.value(forKey: "\(nonNilVal)Count") as! Int) - 1, forKey: "\(nonNilVal)Count")
                                
                                //totals
                                coreDataCategory.setValue((coreDataCategory.value(forKey: "sum") as! Int) - (coreDataEntry.value(forKey: category) as! Int), forKey: "sum")
                                coreDataCategory.setValue(coreDataCategory.value(forKey: "count") as! Int - 1, forKey: "count")
                            }
                        }
                    }
                }
                
            }
            
            PersistenceService.context.delete(coreDataEntry)
            
            PersistenceService.saveContext()
        } catch { }
        
        print("Entry with date \(date) deleted from Core Data")
        
        print("Segueing back to Journal")
        navigationController?.popViewController(animated: true)
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
