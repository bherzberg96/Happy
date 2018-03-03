//
//  NotesViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/25/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        saveNotes()
        
//        coreDataEntry.fun = 8
//        coreDataEntry.health = 8
//        coreDataEntry.mood = 8
//        coreDataEntry.notes = "jasdfjkd"
//        coreDataEntry.overall = 8
//        coreDataEntry.professional = 8
//        coreDataEntry.romantic = 8
//        coreDataEntry.sleep = 8
//        coreDataEntry.social = 8
        
        print("Date: \(coreDataEntry.date)")
        for category in Constants.allCategories {
            print("Category \(category) rated \(coreDataEntry.value(forKey: category))")
        }
        print("Notes: \(coreDataEntry.notes)")
        
        PersistenceService.saveContext()
        self.dismiss(animated: true, completion: nil)
    }
    
    var coreDataEntry : Entry = Entry()
    
    func saveNotes() {
        let notes = textField.text
        if notes != "" {
            coreDataEntry.setValue(notes, forKey: "notes")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
