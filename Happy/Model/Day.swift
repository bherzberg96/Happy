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
    
    func getNextCategory() -> Category {
        for category in categories {
            if category.rating == 0 {
                return category
            }
        }
        return categories[0]
    }
    
}
