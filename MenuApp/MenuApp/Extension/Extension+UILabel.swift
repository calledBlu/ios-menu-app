//
//  Extension+UILabel.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()

        self.text = text
        self.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)
        self.textColor = .white
    }
}
