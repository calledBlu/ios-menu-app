//
//  LikeDayCoreDataManager.swift
//  MenuApp
//
//  Created by Blu on 2023/05/28.
//

import UIKit
import CoreData

final class LikeDayCoreDataManager {

    static var shared: LikeDayCoreDataManager = LikeDayCoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    var menuEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "LikeDay", in: context)
    }

    // MARK: - Create

    func insertDay(_ day: LikeDay) {
        if let entity = menuEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(day.date, forKey: "date")
        }
    }

    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Read

    private func fetchLikeDays() -> [LikeDayMO] {
        do {
            let request = LikeDayMO.fetchRequest()
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    func getLikeDays() -> [LikeDay] {
        var likeDays: [LikeDay] = []
        let fetchResults = fetchLikeDays()
        for result in fetchResults {
            let day = LikeDay(date: result.date)

            likeDays.append(day)
        }

        return likeDays
    }

    // MARK: - Delete

    func deleteLikeDay(_ day: LikeDay) {
        let fetchResults = fetchLikeDays()
        let deleteDay = fetchResults.filter({ $0.date == day.date })[0]
        context.delete(deleteDay)
        saveToContext()
    }

    func deleteAllLikeDays() {
        let fetchResults = fetchLikeDays()
        for result in fetchResults {
            context.delete(result)
        }
        saveToContext()
    }
}
