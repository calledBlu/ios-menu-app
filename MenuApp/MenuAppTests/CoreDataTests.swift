//
//  CoreDataTests.swift
//  MenuAppTests
//
//  Created by Blu on 2023/05/26.
//

import XCTest
import CoreData
@testable import MenuApp

final class CoreDataTests: XCTestCase {
    var sut: DateProvider!
    var coreDB: FoodCoreDataManager!

    override func setUpWithError() throws {
        sut = DateProvider()
        coreDB = FoodCoreDataManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
        coreDB = nil
    }

    func test_CoreData를_저장할_수_있는지() {
        let date = sut.formatter.dateFormat
        let menu = Food(id: UUID(), name: "탕수육", category: Food.Category.chinese, date: Date())

        // swiftlint:disable force_cast
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "Menu", in: context)

        if let entity = entity {
            let menus = NSManagedObject(entity: entity, insertInto: context)
            menus.setValue(menu.id, forKey: "id")
            menus.setValue(menu.date, forKey: "date")
            menus.setValue(menu.category?.rawValue, forKey: "category")
            menus.setValue(menu.name, forKey: "name")
        }

        do {
//            try context.save()
        } catch {
            print(error.localizedDescription)
        }

        fetchMenu()
    }

    func fetchMenu() {
        // swiftlint:disable force_cast
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
        let context = appDelegate.persistentContainer.viewContext

        do {
            // swiftlint:disable force_cast
            let day = try context.fetch(FoodMO.fetchRequest()) as! [FoodMO]
            // swiftlint:enable force_cast
            day.forEach {
                print($0.id)
                print($0.name)
                print($0.date)
                print(Food.Category(rawValue: Int($0.category)) ?? Food.Category.korean.rawValue)

            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func test_현재_날짜에_해당하는_음식을_모두_가져올_수_있는지() {
        let today = Date()
        let yesterday = Date() - 86400

//        let meat = Menu(id: UUID(), name: "잡채밥", category: Menu.FoodCategory.chinese, date: today)
//        let salad = Menu(id: UUID(), name: "샐러드", category: Menu.FoodCategory.western, date: yesterday)
//        let sushi = Menu(id: UUID(), name: "초밥", category: Menu.FoodCategory.japanese, date: today)
//        let rice = Menu(id: UUID(), name: "김치볶음밥", category: Menu.FoodCategory.korean, date: yesterday)
//        let pasta = Menu(id: UUID(), name: "고추장 크림 파스타", category: Menu.FoodCategory.fusion, date: today)
//
//        coreDB.insertMenu(meat)
//        coreDB.saveToContext()
//        coreDB.insertMenu(salad)
//        coreDB.saveToContext()
//        coreDB.insertMenu(sushi)
//        coreDB.saveToContext()
//        coreDB.insertMenu(rice)
//        coreDB.saveToContext()
//        coreDB.insertMenu(pasta)
//        coreDB.saveToContext()
//
//        let menuMO = coreDB.fetchMenus()
        let menu = coreDB.getMenu()

        let menuResult = menu.filter { food in
            food.date == today
        }

        print(menuResult)
    }

    func test_메뉴를_업데이트_할_수_있는가() {
        let today = Date()

        let updateMenu = Food(id: UUID(uuidString: "F330FAA3-CDD3-4CF5-9C65-90CC68E40465")!, name: "간장계란밥", date: today)

        coreDB.updateFood(updateMenu)

        let menu = coreDB.getMenu()

        print(menu)
    }
}
