//
//  CircleView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/25.
//

import UIKit

final class CircleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.backgroundColor = .init(named: "MainBlack")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
