//
//  PopupView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

final class PopupView: UIView {

    private lazy var detailTitleStackView = DetailTitleStackView(frame: .zero)
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionFootersPinToVisibleBounds = true
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumLineSpacing = 20

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    private lazy var buttonStackView = ButtonStackView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configure() {
        configureUI()
        configureLayout()
    }

    private func configureUI() {
        self.backgroundColor = .white
        self.addSubview(detailTitleStackView)
        self.addSubview(collectionView)
        self.addSubview(buttonStackView)
    }

    private func configureLayout() {
        detailTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            detailTitleStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            detailTitleStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.63),
            detailTitleStackView.heightAnchor.constraint(equalToConstant: 40),
            detailTitleStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: detailTitleStackView.bottomAnchor, constant: 24),
            collectionView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),

            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            buttonStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

final class ButtonStackView: UIStackView {
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
}
