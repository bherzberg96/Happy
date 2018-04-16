//
//  OnboardingViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 4/11/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import UserNotifications

class OnboardingViewController: UIViewController {
    @IBAction func yesButton(_ sender: UIButton) {
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
            if let nonNilError = error {
                print(nonNilError)
            } else {
                //notification set up successfully
            }
        })
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        UserDefaults.standard.set(true, forKey: "onboarding")
    }
    
    @IBAction func noButton(_ sender: UIButton) {
         UserDefaults.standard.set(false, forKey: "onboarding")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCategoryCoreData()
        // Do any additional setup after loading the view.
    }
    
    func createCategoryCoreData() {
        for category in Constants.allCategories {
            let newCoreDataCategory = Category(context: PersistenceService.context)
            newCoreDataCategory.setValue(category, forKey: "name")
            PersistenceService.saveContext()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
