//
//  JournalViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import CoreData

class JournalViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        getEntries()
    }
    
    var entries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEntries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getEntries() {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        do {
            let coreDataEntries = try PersistenceService.context.fetch(fetchRequest)
            entries = coreDataEntries
            for entry in entries {
                print("------------------------")
                print("Date: \(entry.date)")
                for category in Constants.allCategories {
                    print("Category \(category) rated \(entry.value(forKey: category))")
                }
                print("Notes: \(entry.notes)")
            }
            self.tableView.reloadData()
        } catch {
            // TODO
        }
    }
}

extension JournalViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let cellDate = entries[indexPath.row].date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY"
        cell.textLabel?.text = dateFormatter.string(from: cellDate!)
        
        return cell
    }
}

