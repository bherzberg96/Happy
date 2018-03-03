////
////  RatingViewController.swift
////  Happy
////
////  Created by Ben Herzberg on 2/17/18.
////  Copyright © 2018 Ben Herzberg. All rights reserved.
////
//
//import UIKit
//import Foundation
//
//class RatingViewController : UIViewController {
//    
//
//    
//    var coreDataEntry : Entry = Entry()
//    
//    var categoryName : String?
//    var rating : Int = 0
//    
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("Post segue: \(coreDataEntry.date)")
//        configureNextButton()
//        
//        categoryName = getNextCategory()
//        if let notNilCategoryName = categoryName {
//            self.title = notNilCategoryName.capitalized
//        } else {
//            self.title = "Notes"
//        }
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    func getNextCategory() -> String? {
//        for category in Constants.allCategories {
//            print("\(category) rated \(coreDataEntry.value(forKey: category))")
//            if let val = coreDataEntry.value(forKey: category) {
//                print(val as! Int)
//                if val as! Int == 0 {
//                    return category
//                }
//            }
//        }
//        
//        return nil
//    }
//    
//    func getTextForNextButton() -> String {
//        var count = 0
//        for category in Constants.allCategories {
//            if let val = coreDataEntry.value(forKey: category) {
//                if val as! Int == 0 {
//                    count += 1
//                    
//                    if count == 2 {
//                        return category.capitalized
//                    }
//                }
//            }
//        }
//        
//        return "Notes"
//    }
//    
////    func lastCategoryLoaded() -> Bool {
////        let categories : [Category] = Array(coreDataEntry.categoryRelationship!) as! [Category]
////        var count = 0
////        for category in categories {
////            if category.rating == 0 {
////                count += 1
////            }
////        }
////
////        return count == 1
////    }
//    
//    func configureNextButton() {
//        nextButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.blue], for: .normal)
//        nextButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.gray], for: .disabled)
//        nextButton.isEnabled = false
//        nextButton.title = "\(getTextForNextButton())"
//    }
//    
//    @IBAction func ratingPressed(_ sender: UIButton) {
//        if (!sender.isSelected) { //if button was not originally selected and is now being selected
//            for rating in ratings {
//                if (rating.tag != sender.tag) {
//                    rating.isSelected = false
//                }
//            }
//            nextButton.isEnabled = true
//            rating = sender.tag
//        } else {
//            nextButton.isEnabled = false
//            rating = 0
//        }
//        sender.isSelected = !sender.isSelected
//    }
//    
//    func saveRating() {
//        coreDataEntry.setValue(rating, forKey: categoryName!)
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}
//
//
//
//
