//
//  AddNewDayViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import Foundation

class AddNewDayViewController : UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    var day : Day?
    var category : Category? = nil
    var ratingSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (day != nil) {
            if (day?.nextCategoryExists())! {
                category = day?.getNextCategory()
            }
            self.title = category?.name
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func ratingPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        ratingSelected = sender.isSelected
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        // Create a variable that you want to send
        var newDay = Day(date: datePicker.date, enabledCategories: getEnabledCategories())
        print("Preparing for segue")
        // Create a new variable to store the instance of PlayerTableViewController
        if (segue.identifier == "nextRating") {
            print("Segueing to 'nextRating' ID")
            print("New day being passed on (\(newDay.date)")
            let destinationVC = segue.destination as! AddNewDayViewController
            destinationVC.day = newDay
        }
    }
    
    func getEnabledCategories() -> [String] {
        let allCategories = ["Mood", "Fun", "Social", "Romantic", "Professional", "Health", "Sleep"]
        var enabledCategories = [String]()
        for category in allCategories {
            if (UserDefaults.standard.bool(forKey: category)) {
                enabledCategories.append(category)
            }
        }
        return enabledCategories
    }
}

