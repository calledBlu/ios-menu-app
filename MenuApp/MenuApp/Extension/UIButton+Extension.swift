//
//  UIButton+Extension.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import UIKit

extension UIButton {
    convenience init(systemName: String) {
        self.init()

        self.tintColor = .systemBlue
        self.setImage(UIImage(systemName: systemName), for: .normal)
    }
}
