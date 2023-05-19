//
//  ListViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

final class ListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }

    private func configureNavigationBar() {
        let titleLabel =  NavigationBarTitleLabel(text: "저장된 날짜 리스트")

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }
}
