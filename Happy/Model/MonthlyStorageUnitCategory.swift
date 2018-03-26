//
//  MonthlyStorageUnitCategory.swift
//  Happy
//
//  Created by Ben Herzberg on 3/20/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//

import Foundation

class MonthlyStorageUnitCategory {
    var sum : Int
    var count : Int
    
    init() {
        sum = 0
        count = 0
    }
    
    func addVal(val: Int) {
        sum += val
        count += 1
    }
    
    func removeVal(val: Int) {
        sum -= val
        count -= 1
    }
    
    func getAvg() -> Double {
        return Double(sum)/Double(count)
    }
}
