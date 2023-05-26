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
    
    var delegate: CalendarTitleStackViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureTitleView()
        configureButtonFunctuion()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateDateTitle(date: String) {
        title.text = date
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
        divider.backgroundColor = .init(named: "SubGray")

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
        title.text = "2023년 00월"
        title.font = UIFont(name: "Pretendard-Bold", size: 16)
        title.textAlignment = .center
        title.textColor = UIColor.init(named: "MainBlack")
    }

    private func configureButtonFunctuion() {
        previousButton.addTarget(self, action: #selector(didPreviousButtonTouched(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didNextButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func didPreviousButtonTouched(_ sender: UIButton) {
        delegate?.movePreviousMonth()
    }

    @objc private func didNextButtonTouched(_ sender: UIButton) {
        delegate?.moveNextMonth()
    }
}

protocol CalendarTitleStackViewDelegate: AnyObject {
    func movePreviousMonth()
    func moveNextMonth()
}
