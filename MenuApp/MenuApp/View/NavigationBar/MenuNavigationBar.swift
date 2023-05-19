//
//  MenuNavigationBar.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

final class MenuNavigationBar: UINavigationBar {
    private var navigationBarTitleLabel: NavigationBarTitleLabel?

    convenience init(pageTitle: String) {
        self.init()

        self.barTintColor = .systemRed
        configureNavigationItem(title: pageTitle)
    }

    private func configureNavigationItem(title: String) {
        let titleLabel = NavigationBarTitleLabel(text: title)

        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)

        self.items = [navigationItem]
        self.delegate = self
    }
}
