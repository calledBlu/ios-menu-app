//
//  NavigationBarTitleLabel.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

final class NavigationBarTitleLabel: UILabel {
    convenience init(text: String) {
        self.init()

        self.text = text
        self.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)
        self.textColor = .white
    }
}
