//
//  DayPickerViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import Foundation

class DayPickerViewController : UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        coreDataEntry = Entry()
        self.dismiss(animated: true, completion: nil)
    }
    
    var coreDataEntry : Entry = Entry(context: PersistenceService.context)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        // Create a variable that you want to send
        coreDataEntry.date = datePicker.date
        print("Pre segue: \(coreDataEntry.date)")
        addEnabledCategories()
        
//        var newDay = Day(date: datePicker.date, enabledCategories: getEnabledCategories())
        print("Preparing for segue")
        // Create a new variable to store the instance of PlayerTableViewController
        if (segue.identifier == "nextRating") {
            print("Segueing to 'nextRating' ID")
            print("New day being passed on (\(coreDataEntry.date)")
            let destinationVC = segue.destination as! RatingViewController
            destinationVC.coreDataEntry = coreDataEntry
        }
    }
    
    func addEnabledCategories() {
        for category in Constants.allCategories {
            if UserDefaults.standard.bool(forKey: category) {
                coreDataEntry.setValue(0, forKey: category)
                print("\(category) rated \(coreDataEntry.value(forKey: category))")
            }
        }
        
        coreDataEntry.setValue(0, forKey: "overall")
    }
}

