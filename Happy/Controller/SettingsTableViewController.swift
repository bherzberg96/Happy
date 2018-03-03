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
            defaults.set(sender.isOn, forKey: "mood")
        case 1:
            defaults.set(sender.isOn, forKey: "fun")
        case 2:
            defaults.set(sender.isOn, forKey: "social")
        case 3:
            defaults.set(sender.isOn, forKey: "romantic")
        case 4:
            defaults.set(sender.isOn, forKey: "professional")
        case 5:
            defaults.set(sender.isOn, forKey: "health")
        case 6:
            defaults.set(sender.isOn, forKey: "sleep")
        default:
            print("Unknown sender ID on switchToggled.")
        }
    }
    
    func setCategorySwitches() {
        moodSwitch.setOn(defaults.bool(forKey: "mood"), animated: false)
        funSwitch.setOn(defaults.bool(forKey: "fun"), animated: false)
        socialSwitch.setOn(defaults.bool(forKey: "social"), animated: false)
        romanticSwitch.setOn(defaults.bool(forKey: "romantic"), animated: false)
        professionalSwitch.setOn(defaults.bool(forKey: "professional"), animated: false)
        healthSwitch.setOn(defaults.bool(forKey: "health"), animated: false)
        sleepSwitch.setOn(defaults.bool(forKey: "sleep"), animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategorySwitches()

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
