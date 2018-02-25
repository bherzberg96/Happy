//
//  Day.swift
//  Happy
//
//  Created by Ben Herzberg on 2/21/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import Foundation

class Day {
    
    let date : Date
    var categories = [Category]()
    var notes : String?
    
    init(date: Date, enabledCategories: [String]) {
        self.date = date
        for category in enabledCategories {
            let tempCategory = Category(name: category, rating: 0)
            categories.append(tempCategory)
        }
    }
    
    func nextCategoryExists() -> Bool {
        for category in categories {
            if category.rating == 0 {
                return true
            }
        }
        return false
    }
    
    func lastCategoryLoaded() -> Bool {
        var count = 0
        for category in categories {
            if category.rating == 0 {
                count += 1
            }
        }
        
        if (count == 1) {
            return true
        }
        return false
    }
    
    func getNextCategory() -> Category {
        for category in categories {
            if category.rating == 0 {
                return category
            }
        }
        return categories[0]
    }
    
    func getCategoryForNextButton() -> Category {
        var firstEmptyCategoryFound = false
        for category in categories {
            if category.rating == 0 {
            if !firstEmptyCategoryFound {
                firstEmptyCategoryFound = true
            } else {
                return category
                }
            }
        }
        return categories[0]
    }
    
}
