//
//  Date+CoreDataProperties.swift
//  Happy
//
//  Created by Ben Herzberg on 3/1/18.
//  Copyright © 2018 Ben Herzberg. All rights reserved.
//
//

import Foundation
import CoreData


extension Date {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Date> {
        return NSFetchRequest<Date>(entityName: "Date")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var categoryRelationship: NSSet?

}

// MARK: Generated accessors for categoryRelationship
extension Date {

    @objc(addCategoryRelationshipObject:)
    @NSManaged public func addToCategoryRelationship(_ value: Category)

    @objc(removeCategoryRelationshipObject:)
    @NSManaged public func removeFromCategoryRelationship(_ value: Category)

    @objc(addCategoryRelationship:)
    @NSManaged public func addToCategoryRelationship(_ values: NSSet)

    @objc(removeCategoryRelationship:)
    @NSManaged public func removeFromCategoryRelationship(_ values: NSSet)

}
