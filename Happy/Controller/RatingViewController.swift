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

    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
//        let viewController:RatingViewController = RatingViewController
//        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
//        viewController.day = day
//        self.present(viewController, animated: false, completion: nil)
        saveRating()
        let newVC: RatingViewController = storyboard?.instantiateViewController(withIdentifier: "rating") as! RatingViewController
        newVC.day = self.day
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    var day : Day?
    var category : Category? = nil
    var ratingSelected = false
    var rating : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (day != nil) {
            if (day?.nextCategoryExists())! {
                category = day?.getNextCategory()
                self.title = category?.name
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        ratingSelected = sender.isSelected
        rating = sender.tag
    }
    
    func saveRating() {
        if let i = day?.categories.index(where: { $0.name == category?.name }) {
            day?.categories[i].rating = rating
            print("\(category?.name) rating is now \(rating)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


