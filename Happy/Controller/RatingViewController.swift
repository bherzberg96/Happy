//
//  RatingViewController.swift
//  Happy
//
//  Created by Ben Herzberg on 2/17/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import UIKit
import Foundation

class RatingViewController : UIViewController {
    
    @IBOutlet var ratings: [UIButton]!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        saveRating()
        if lastCategoryLoaded {
            let newVC: NotesViewController = storyboard?.instantiateViewController(withIdentifier: "notes") as! NotesViewController
            newVC.day = self.day
            self.navigationController?.pushViewController(newVC, animated: true)            
        } else {
            let newVC: RatingViewController = storyboard?.instantiateViewController(withIdentifier: "rating") as! RatingViewController
            newVC.day = self.day
            self.navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
    var day = Day(date: Date(), enabledCategories: [])
    var category = Category(name: "PLACEHOLDER", rating: 0)
    var rating : Int = 0
    var lastCategoryLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNextButton()
        
        if (day.nextCategoryExists()) {
            category = day.getNextCategory()
            self.title = category.name
        }
        //        else {
        //            self.dismiss(animated: true, completion: nil)
        //        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureNextButton() {
        nextButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.blue], for: .normal)
        nextButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.gray], for: .disabled)
        nextButton.isEnabled = false
        if (day.lastCategoryLoaded()) {
            lastCategoryLoaded = true
            nextButton.title = "Notes >"
        } else {
            nextButton.title = "\(day.getCategoryForNextButton().name) >"
        }
    }
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        if (!sender.isSelected) { //if button was not originally selected and is now being selected
            for rating in ratings {
                if (rating.tag != sender.tag) {
                    rating.isSelected = false
                }
            }
            nextButton.isEnabled = true
            rating = sender.tag
        } else {
            nextButton.isEnabled = false
            rating = 0
        }
        sender.isSelected = !sender.isSelected
    }
    
    func saveRating() {
        if let i = day.categories.index(where: { $0.name == category.name }) {
            day.categories[i].rating = rating
            print("\(category.name) rating is now \(rating)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


