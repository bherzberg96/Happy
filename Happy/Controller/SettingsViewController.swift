//
//  SettingsViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var notificationTimeLabel: UILabel!
    
//    let sections = ["Notifications", "Categories"]
//    let notifications = ["Notification Time"]
//    let categories = ["Health", "Mood", "Work", "School", "Social"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return notifications.count
//        case 1:
//            return categories.count
//        default:
//            return 0
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // Create an object of the dynamic cell “PlainCell”
//        let plainCell = tableView.dequeueReusableCell(withIdentifier: "plainCell", for: indexPath)
//        let timeCell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
//        let switchCell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath)
//        // Depending on the section, fill the textLabel with the relevant text
//        switch indexPath.section {
//        case 0:
//            timeCell.textLabel?.text = notifications[indexPath.row]
//            return timeCell
//        case 1:
//            switchCell.textLabel?.text = categories[indexPath.row]
//            return switchCell
//        default:
//            break
//        }
//        return plainCell;
//    }
}
