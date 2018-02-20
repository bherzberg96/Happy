//
//  SettingsTableViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/20/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var healthSwitch: UISwitch!
    @IBOutlet weak var moodSwitch: UISwitch!
    @IBOutlet weak var socialSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
