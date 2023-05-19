//
//  HomeViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/18.
//

import UIKit

final class MenuTabBarController: UIViewController {

    private let navigationBar = MenuNavigationBar(pageTitle: "주식회사 야곰 식단표")

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBarLayout()
    }

    private func configureNavigationBarLayout() {
        view.addSubview(navigationBar)

        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}

//final class HomeViewController: UIViewController {
//
//    private let navigationBar = MenuNavigationBar(pageTitle: "주식회사 야곰 식단표")
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureNavigationBarLayout()
//    }
//
//    private func configureNavigationBarLayout() {
//        view.addSubview(navigationBar)
//
//        navigationBar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
//            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
//            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//        ])
//    }
//}

//final class MenuTabBarController: UITabBarController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureTabBar()
//    }
//
//    private func configureTabBar() {
//        let tabBar = UITabBar()
//
//        view.addSubview(tabBar)
//
//        let listItem = UITabBarItem(title: "리스트", image: UIImage(systemName: "list.bullet.clipboard"), tag: 1)
//        let calendarItem = UITabBarItem(title: "캘린더", image: UIImage(systemName: "calendar"), tag: 0)
//        let alertItem = UITabBarItem(title: "푸시알림", image: UIImage(systemName: "bell"), tag: 2)
//
//        tabBar.items = [listItem, calendarItem, alertItem]
//        tabBar.delegate = self
//    }
//}
