//
//  PopupView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

final class PopupView: UIView {
    private lazy var detailTitleStackView = DetailTitleStackView(frame: .zero)
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionFootersPinToVisibleBounds = true
        layout.sectionHeadersPinToVisibleBounds = true

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    lazy var buttonStackView = ButtonStackView(frame: .zero)

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
        collectionView.register(cell: MenuListCell.self)
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

