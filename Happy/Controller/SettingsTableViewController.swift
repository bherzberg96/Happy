//
//  SettingsTableViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/20/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var moodSwitch: UISwitch!
    @IBOutlet weak var funSwitch: UISwitch!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var romanticSwitch: UISwitch!
    @IBOutlet weak var professionalSwitch: UISwitch!
    @IBOutlet weak var healthSwitch: UISwitch!
    @IBOutlet weak var sleepSwitch: UISwitch!
    @IBOutlet weak var notificationTime: UILabel!
    
    let defaults = UserDefaults.standard
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            defaults.set(sender.isOn, forKey: "Mood")
        case 1:
            defaults.set(sender.isOn, forKey: "Fun")
        case 2:
            defaults.set(sender.isOn, forKey: "Social")
        case 3:
            defaults.set(sender.isOn, forKey: "Romantic")
        case 4:
            defaults.set(sender.isOn, forKey: "Professional")
        case 5:
            defaults.set(sender.isOn, forKey: "Health")
        case 6:
            defaults.set(sender.isOn, forKey: "Sleep")
        default:
            print("Unknown sender ID on switchToggled.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Output -> { key:hello;}

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
