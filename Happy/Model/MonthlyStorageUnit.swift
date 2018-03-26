//
//  MonthlyStorageUnit.swift
//  Happy
//
//  Created by Ben Herzberg on 3/20/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import Foundation

class MonthlyStorageUnit {
    var month : Int
    var year : Int
    var categories : [String : MonthlyStorageUnitCategory]
    
    init(month: Int, year: Int) {
        self.month = month
        self.year = year
        categories = [String : MonthlyStorageUnitCategory]()
    }
    
    func addEntry(category: String, val: Int) {
        if categories[category] == nil {
            categories[category] = MonthlyStorageUnitCategory()
        }
        
        categories[category]!.addVal(val: val)
    }
    
    func removeEntry(category: String, val: Int) {
        if categories[category] != nil { //should always not be nil
            categories[category]!.removeVal(val: val)
        }
    }
    
    func getAvg(category: String) -> Double {
        if categories[category] != nil {
            return categories[category]!.getAvg()
        }
        
        return 0.0
    }
}
