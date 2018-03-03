//
//  CellTappedViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 3/3/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit

struct EntryStruct {
    let key: String
    let value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

class CellTappedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var entry = [EntryStruct]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var count = 0
//
//        for item in entry {
//            if (item.key != "notes") {
//                if item.value != "nil" && item.value != "" {
//                    count += 1
//                }
//            } else {
//                count += 1
//            }
//        }
//
//        return count
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
        let coreDataEntry = entries[myIndex]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY"
//        entry.updateValue(dateFormatter.string(from: coreDataEntry.date!), forKey: "date")
        entry.append(EntryStruct(key: "date", value: dateFormatter.string(from: coreDataEntry.date!)))
        
        for category in Constants.allCategories {
//            entry.updateValue(coreDataEntry.value(forKey: category), forKey: category)
            if let entryVal = coreDataEntry.value(forKey: category) {
                entry.append(EntryStruct(key: category, value: "\(entryVal)"))
            }
        }
        
//        entry.updateValue(coreDataEntry.notes, forKey: "notes")
        entry.append(EntryStruct(key: "notes", value: "\(coreDataEntry.notes!)"))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
