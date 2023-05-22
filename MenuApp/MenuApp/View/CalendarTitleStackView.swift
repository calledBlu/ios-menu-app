//
//  CalendarTitleStackView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import UIKit

final class CalendarTitleStackView: RoundedStackView {
    private lazy var previousButton = UIButton(systemName: "chevron.left")
    private lazy var nextButton = UIButton(systemName: "chevron.right")
    private lazy var title = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureTitleView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTitleView() {
        configurePaddingView()
        self.addArrangedSubview(previousButton)
        configureDivider()
        configureTitleLabel()
        configureDivider()
        self.addArrangedSubview(nextButton)
        configurePaddingView()
    }

    private func configurePaddingView() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width / 5, height: 0))
        self.addArrangedSubview(paddingView)
    }

    private func configureDivider() {
        let divider = UIView()
        divider.backgroundColor = .lightGray

        self.addArrangedSubview(divider)

        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            divider.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])
    }

    private func configureTitleLabel() {
        self.addArrangedSubview(title)
        title.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        title.textAlignment = .center
    }

    func updateDateTitle(date: String) {
        title.text = date
    }
}
