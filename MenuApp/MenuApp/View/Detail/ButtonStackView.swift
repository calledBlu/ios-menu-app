//
//  ButtonStackView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

protocol ButtonStackViewDelegate: AnyObject {
    func moveAddView()
    func dismissCurrentView()
}

final class ButtonStackView: UIStackView {
    var delegate: ButtonStackViewDelegate?

    private let buttonFont = UIFont(name: "Pretendard-Regular", size: 14)
    private lazy var addButton = UIButton()
    private lazy var closeButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.distribution = .fillEqually
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure() {
        configureUI()
        configureButtonStyle()
        configureButtonFunctuion()
    }

    private func configureUI() {
        self.addArrangedSubview(addButton)
        self.addArrangedSubview(closeButton)
    }

    private func configureButtonStyle() {
        guard let font = buttonFont,
              let color = UIColor.init(named: "SubBlack") else {
            return
        }

        addButton.setAttributedTitle(NSAttributedString(string: "추가",
                                                        attributes: [.font: font,
                                                                     .foregroundColor: color]),
                                     for: .normal)
        addButton.backgroundColor = UIColor.init(named: "SubLightGray")

        closeButton.setAttributedTitle(NSAttributedString(string: "닫기",
                                                          attributes: [.font: font, .foregroundColor: UIColor.white]),
                                       for: .normal)
        closeButton.backgroundColor = UIColor.init(named: "MainOrange")
    }

    private func configureButtonFunctuion() {
        addButton.addTarget(self, action: #selector(didAddButtonTouched(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(didCloseButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func didAddButtonTouched(_ sender: UIButton) {
        delegate?.moveAddView()
    }

    @objc private func didCloseButtonTouched(_ sender: UIButton) {
        delegate?.dismissCurrentView()
    }
}
