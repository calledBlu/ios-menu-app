//
//  PushAlertViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

final class PushAlertViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }

    private func configureNavigationBar() {
        let titleLabel =  NavigationBarTitleLabel(text: "푸시 알림 설정")

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }
}
