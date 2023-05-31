//
//  PushAlertViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

final class PushAlertViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }

    // MARK: - Private Methods

    private func configureNavigationBar() {
        let titleLabel = UILabel(text: ViewCategory.pushAlert.viewTitle)
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 18)

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }
}
