//
//  SettingsTableViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/20/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit

extension UIToolbar {
    func ToolbarPicker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var moodSwitch: UISwitch!
    @IBOutlet weak var funSwitch: UISwitch!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var romanticSwitch: UISwitch!
    @IBOutlet weak var professionalSwitch: UISwitch!
    @IBOutlet weak var healthSwitch: UISwitch!
    @IBOutlet weak var sleepSwitch: UISwitch!
    @IBOutlet weak var notificationTime: UILabel!
    let datePicker = UIDatePicker()
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
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
