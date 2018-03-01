//
//  Category+CoreDataProperties.swift
//  Happy
//
//  Created by Ben Herzberg on 3/1/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var rating: Int16
    @NSManaged public var enabled: Bool

}
