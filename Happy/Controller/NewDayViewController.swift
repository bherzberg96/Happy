//
//  NewDayViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class NewDayViewController : UIViewController {

    // All
    var date = Date()
    var categories = [String : Int]()
    var dateFormatter = DateFormatter()

    override func viewDidLoad() {
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone.current
        
        super.viewDidLoad()
        
        if (self.restorationIdentifier == "datePicker") {
            datePicker.maximumDate = Date()
        } else if (self.restorationIdentifier == "rating") {
            configureNextButton()
        
            category = getNextCategory()
            if let notNilCategoryName = category {
                self.title = notNilCategoryName.capitalized
            } else {
                self.title = "Notes"
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Date Picker
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let date = datePicker.date
        
        let localDate = dateFormatter.date(from: dateFormatter.string(from: date))
        
        if (entryForDateAlreadyExists(date: localDate!)) {
            let alert = UIAlertController(title: "Entry already exists", message: "You have already logged an entry for this day.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if (segue.identifier == "nextRating") {
                let destinationVC = segue.destination as! NewDayViewController
                destinationVC.date = date
                destinationVC.categories =
                    getEnabledCategories()
            }
        }
    }
    
    func entryForDateAlreadyExists(date : Date) -> Bool {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        do {
            entries = try PersistenceService.context.fetch(fetchRequest)
            for entry in entries {
                if (entry.date == date) {
                    return true
                }
            }
        } catch {
            // TODO
        }
        
        return false
    }
    
    func getEnabledCategories() -> [String : Int] {
        var enabledCategories = [String : Int]()
        for category in Constants.allCategories {
            if (UserDefaults.standard.bool(forKey: category)) {
                enabledCategories[category] = 0
            }
        }
        
        enabledCategories["overall"] = 0
        
        return enabledCategories
    }
    
    // Ratings
    var category : String?
    var rating : Int = 0
    @IBOutlet var ratings: [UIButton]!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        saveRating()
        
        var destinationVC = NewDayViewController()
        if nextButton.title == "Notes" {
            destinationVC = storyboard?.instantiateViewController(withIdentifier: "notes") as! NewDayViewController
        } else {
            destinationVC = storyboard?.instantiateViewController(withIdentifier: "rating") as! NewDayViewController
        }
        destinationVC.date = date
        destinationVC.categories = self.categories
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        if (!sender.isSelected) { //if button was not originally selected and is now being selected
            for rating in ratings {
                if (rating.tag != sender.tag) {
                    rating.isSelected = false
                }
            }
            nextButton.isEnabled = true
            rating = sender.tag
        } else {
            nextButton.isEnabled = false
            rating = 0
        }
        sender.isSelected = !sender.isSelected
    }
    
    func getTextForNextButton() -> String {
        var count = 0
        for category in Constants.allCategories {
                if categories[category] == 0 {
                    count += 1
                    
                    if count == 2 {
                        return category.capitalized
                    }
                }
            }
        
        return "Notes"
    }
    
    func getNextCategory() -> String? {
        for category in Constants.allCategories {
            if categories[category] == 0 {
                return category
            }
        }
        
        return nil
    }
    
    func saveRating() {
        categories.updateValue(rating, forKey: category!)
    }
    
    func configureNextButton() {
        nextButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.blue], for: .normal)
        nextButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.gray], for: .disabled)
        nextButton.isEnabled = false
        nextButton.title = "\(getTextForNextButton())"
    }
    
    // Notes
    @IBOutlet weak var textField: UITextField!
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let coreDataEntry = Entry(context: PersistenceService.context)
        coreDataEntry.date = date
        for (key, value) in categories {
            if categories[key] != nil {
                coreDataEntry.setValue(value, forKey: key)
            }
        }
        let val = textField.text
        coreDataEntry.setValue(textField.text, forKey: "notes")
        
        PersistenceService.saveContext()
        
        print("Date: \(coreDataEntry.date)")
        for category in Constants.allCategories {
            print("Category \(category) rated \(coreDataEntry.value(forKey: category))")
        }
        print("Notes: \(coreDataEntry.notes)")
        
        //////////////
        
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let month = monthFormatter.string(from: Date())
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let year = yearFormatter.string(from: Date())
        
        let previousMonths = getPreviousMonths(numberOfMonths: Constants.previousMonthsCount, month: month, year: year)
        
        do {
            let coreDataCategories = try PersistenceService.context.fetch(categoryFetchRequest)
            let cat = coreDataCategories.first(where: {$0.name == category})
            
            let yearAndMonthFormatter = DateFormatter()
            yearAndMonthFormatter.dateFormat = "yyyy/MM"
            let yearAndMonth = yearAndMonthFormatter.string(from: date)
            
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
                                coreDataCategory.setValue((coreDataCategory.value(forKey: "\(nonNilVal)Sum") as! Int) + (coreDataEntryVal as! Int), forKey: "\(nonNilVal)Sum")
                                
                                //count
                                coreDataCategory.setValue((coreDataCategory.value(forKey: "\(nonNilVal)Count") as! Int) + 1, forKey: "\(nonNilVal)Count")
                               
                               //totals
                                coreDataCategory.setValue((coreDataCategory.value(forKey: "sum") as! Int) + (coreDataEntry.value(forKey: category) as! Int), forKey: "sum")
                                coreDataCategory.setValue(coreDataCategory.value(forKey: "count") as! Int + 1, forKey: "count")
                            }
                        }
                    }
                }
                
            }
            
            PersistenceService.saveContext()
        } catch { }
        
        //////////
        
        self.dismiss(animated: true, completion: nil)
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
}
