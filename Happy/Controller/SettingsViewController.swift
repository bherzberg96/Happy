//
//  SettingsViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsViewController: UIViewController {
    @IBOutlet weak var notificationTimeLabel: UILabel!
    
//    let sections = ["Notifications", "Categories"]
//    let notifications = ["Notification Time"]
//    let categories = ["Health", "Mood", "Work", "School", "Social"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func notification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        
        let content = UNMutableNotificationContent()
        content.title = "Log your day"
        content.body = "Don't forget to log your day before you go to bed!"
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.timeZone = TimeZone.current
        dateComponents.hour = 21
        dateComponents.minute = 00
        let yourFireDate = Calendar.current.date(from: dateComponents)
        
        let compiledDate = Calendar.current.dateComponents(Set(arrayLiteral:  Calendar.Component.hour, Calendar.Component.minute), from: yourFireDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: compiledDate, repeats: false)
        let request = UNNotificationRequest(identifier: "log", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if let error = error {
                //handle error
            } else {
                //notification set up successfully
            }
        })
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
