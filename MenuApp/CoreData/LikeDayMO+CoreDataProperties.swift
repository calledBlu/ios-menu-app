//
//  LikeDayMO+CoreDataProperties.swift
//  MenuApp
//
//  Created by Blu on 2023/05/28.
//
//

import Foundation
import CoreData

extension LikeDayMO {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikeDayMO> {
        return NSFetchRequest<LikeDayMO>(entityName: "LikeDay")
    }

    @NSManaged public var date: Date
}

extension LikeDayMO: Identifiable {

}
