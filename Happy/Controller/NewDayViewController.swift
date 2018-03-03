//
//  NewDayViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import Foundation

class NewDayViewController : UIViewController {

    // All
    var date = Date()
    var categories = [String : Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.restorationIdentifier == "rating") {
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
        // Create a variable that you want to send
        let date = datePicker.date
        
        print("Preparing for segue")
        if (segue.identifier == "nextRating") {
            print("Segueing to 'nextRating' ID")
            print("New day being passed on (\(date)")
            let destinationVC = segue.destination as! NewDayViewController
            destinationVC.date = date
            destinationVC.categories =
                getEnabledCategories()
        }
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
            print("\(category) rated \(categories[category])")
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
        coreDataEntry.notes = textField.text
        PersistenceService.saveContext()
        
//        print("Date: \(coreDataEntry.date)")
//        for category in Constants.allCategories {
//            print("Category \(category) rated \(coreDataEntry.value(forKey: category))")
//        }
//        print("Notes: \(coreDataEntry.notes)")
        
        self.dismiss(animated: true, completion: nil)
    }
}
