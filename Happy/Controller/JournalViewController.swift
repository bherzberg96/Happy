//
//  JournalViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import CoreData

var entries = [Entry]()
var myIndex : Int = 0

class JournalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "default")
        let cellDate = entries[indexPath.row].date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY"
        cell.textLabel?.text = dateFormatter.string(from: cellDate!)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        
        print("Performing segue to Cell Tapped")
        performSegue(withIdentifier: "cellTapped", sender: self)
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        getEntries()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEntries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getEntries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getEntries() {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Entry.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            entries = try PersistenceService.context.fetch(fetchRequest)
            
            // Print statements
            print("Number of entires in Core Data: \(entries.count)")
            if entries.count > 0 {
                print("Entries in Core Data:")
                for entry in entries {
                    print("\t\(entry.date)")
                }
            }
    
            tableView.reloadData()
            print("Reloading tableView")
        } catch {
            // TODO
        }
    }
}

