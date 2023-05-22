//
//  RoundedStackView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import UIKit

class RoundedStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureShape()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureShape() {
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = 10
        self.alignment = .center
        self.backgroundColor = .white

        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.borderWidth = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 5
    }
}
