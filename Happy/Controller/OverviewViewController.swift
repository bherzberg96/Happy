//
//  OverviewViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var bottomLabel: UILabel!
    let defaults = UserDefaults.standard
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        bottomLabel.text = "\(defaults.bool(forKey: "healthSwitch"))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
}
