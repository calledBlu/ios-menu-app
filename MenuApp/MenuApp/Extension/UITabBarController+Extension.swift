//
//  UITabBarController+Extension.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

extension UITabBarController {
    func createTabBarItem(tabBarTitle: String,
                          tabBarImage: String,
                          viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = tabBarTitle
        navigationController.tabBarItem.image = UIImage(systemName: tabBarImage)

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .init(named: "MainOrange")
        navigationController.navigationBar.standardAppearance = navigationBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController.view.backgroundColor = .white

        return navigationController
    }
}
