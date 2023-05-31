//
//  FoodMO+CoreDataProperties.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//
//

import Foundation
import CoreData

extension FoodMO {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodMO> {
        return NSFetchRequest<FoodMO>(entityName: "Food")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var category: Int16
    @NSManaged public var date: Date
    @NSManaged public var image: Data?
}

extension FoodMO: Identifiable {

}
