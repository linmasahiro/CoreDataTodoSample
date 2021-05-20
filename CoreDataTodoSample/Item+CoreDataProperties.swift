//
//  Item+CoreDataProperties.swift
//  CoreDataTodoSample
//
//  Created by CHENGHUNG on 2021/05/20.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isComplete: Bool

}

extension Item : Identifiable {

}
