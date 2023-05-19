//
//  HomeViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/18.
//

import UIKit

final class HomeViewController: UIViewController {

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
