//
//  MenuTabBarController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/18.
//

import UIKit

final class MenuTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createTabBarItem(tabBarTitle: ViewCategory.list.barTitle,
                             tabBarImage: ViewCategory.list.imageName,
                             viewController: ListViewController()),
            createTabBarItem(tabBarTitle: ViewCategory.calendar.barTitle,
                             tabBarImage: ViewCategory.calendar.imageName,
                             viewController: CalendarViewController()),
            createTabBarItem(tabBarTitle: ViewCategory.pushAlert.barTitle,
                             tabBarImage: ViewCategory.pushAlert.imageName,
                             viewController: PushAlertViewController())
        ]

        configureTabBar()
    }

    private func configureTabBar() {
        let tabBar = self.tabBar

        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemBlue
        tabBar.layer.borderWidth = 0.2
        tabBar.layer.borderColor = UIColor.gray.cgColor

        self.selectedIndex = ViewCategory.calendar.rawValue
    }
}
