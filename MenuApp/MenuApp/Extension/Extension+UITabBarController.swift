//
//  Extension+UITabBarController.swift
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

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .systemBlue
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController.view.backgroundColor = .white

        return navigationController
    }
}
