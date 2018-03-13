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
        populateWithFakeData(limit: 0)
    }
    
    func deleteOldData() {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        do {
            let coreDataEntires = try PersistenceService.context.fetch(fetchRequest)
            for entry in coreDataEntires {
                PersistenceService.context.delete(entry)
            }
            
            PersistenceService.saveContext()
        } catch { }
    }
    
    func populateWithFakeData(limit : Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        var i = 0
        
        while i < limit {
            let date = formatter.date(from: Constants.fakeDates[i])
            let coreDataEntry = Entry(context: PersistenceService.context)
            coreDataEntry.setValue(date, forKey: "date")
            for category in Constants.allCategories {
                let randomInt = arc4random_uniform(9)+1
                coreDataEntry.setValue(randomInt, forKey: category)
            }
            coreDataEntry.setValue("Blah blah blah", forKey: "notes")
            i += 1
        }
        
        if limit > 0 {
            PersistenceService.saveContext()
        }
    }
    
    func getAverage(category: String) -> Double {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Entry.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        var count : Double = 0
        var sum : Double = 0
        
        do {
            entries = try PersistenceService.context.fetch(fetchRequest)
            for entry in entries {
                if let val = entry.value(forKey: category) {
                    sum += val as! Double
                }
                count += 1
            }
        } catch {
            // TODO
        }
        
        return sum/count
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
