//
//  UILabel+Extension.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()

        self.text = text
        self.font = UIFont(name: "Pretendard-Bold", size: 18)
        self.textColor = .white
    }
}
