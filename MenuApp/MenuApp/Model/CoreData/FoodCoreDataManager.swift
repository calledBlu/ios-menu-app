//
//  MenuCoreDataManager.swift
//  MenuApp
//
//  Created by Blu on 2023/05/27.
//

import UIKit
import CoreData

final class FoodCoreDataManager {

    static var shared: FoodCoreDataManager = FoodCoreDataManager()

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

    var foodEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "Food", in: context)
    }

    // MARK: - Create

    func insertFood(_ food: Food) {
        if let entity = foodEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(food.id, forKey: "id")
            managedObject.setValue(food.date, forKey: "date")
            managedObject.setValue(food.category?.rawValue, forKey: "category")
            managedObject.setValue(food.name, forKey: "name")

            if food.image != nil {
                managedObject.setValue(food.image, forKey: "image")
            }
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

    private func fetchMenu() -> [FoodMO] {
        do {
            let request = FoodMO.fetchRequest()
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    func getMenu() -> [Food] {
        var menu: [Food] = []
        let fetchResults = fetchMenu()
        for result in fetchResults {
            let food = Food(id: result.id,
                            name: result.name,
                            category: Food.Category(rawValue: Int(result.category)) ?? .korean,
                            date: result.date,
                            image: result.image ?? Data())

            menu.append(food)
        }

        return menu
    }

    // MARK: - Update

    func updateFood(_ food: Food) {
        let fetchResults = fetchMenu()
        for result in fetchResults {
            if result.id == food.id {
                result.name = food.name
                result.category = Int16(food.category?.rawValue ?? 0)
                result.image = food.image
                result.date = food.date
            }
        }
        saveToContext()
    }

    // MARK: - Delete

    func deleteFood(_ food: Food) {
        let fetchResults = fetchMenu()
        let deleteMenu = fetchResults.filter({ $0.id == food.id })[0]
        context.delete(deleteMenu)
        saveToContext()
    }

    func deleteAllMenu() {
        let fetchResults = fetchMenu()
        for result in fetchResults {
            context.delete(result)
        }
        saveToContext()
    }
}
