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

        self.tintColor = .init(named: "MainOrange")
        let image = UIImage(systemName: systemName)

        self.setImage(image, for: .normal)
    }

    convenience init(systemName: String, pointSize: CGFloat) {
        self.init()

        self.tintColor = .init(named: "MainOrange")
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .light)
        let image = UIImage(systemName: systemName, withConfiguration: imageConfig)

        self.setImage(image, for: .normal)
    }
}
