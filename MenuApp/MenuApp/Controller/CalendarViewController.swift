//
//  CalendarViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

final class CalendarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }

    private func configureNavigationBar() {
        let titleLabel =  NavigationBarTitleLabel(text: ViewCategory.calendar.viewTitle)

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }
}
