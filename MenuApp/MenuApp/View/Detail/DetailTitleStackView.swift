//
//  DetailTitleStackView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

final class DetailTitleStackView: RoundedStackView {
    private lazy var detailTitle = UILabel()
    private lazy var likeButton = UIButton(systemName: "heart.fill")
    private lazy var likeIcon = UIImageView(image: UIImage(systemName: "heart.fill"))

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureTitleView()
        configureButtonFunctuion()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateDateTitle(date: String) {
        self.detailTitle.text = date
    }

    private func configureTitleView() {
        configurePaddingView()
        configureTitleLabel()
        configureDivider()
//        self.addArrangedSubview(likeIcon)
        self.addArrangedSubview(likeButton)
        likeIcon.tintColor = .init(named: "MainOrange")
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
        self.addArrangedSubview(detailTitle)
        detailTitle.text = "04월 02일 수요일"
        detailTitle.font = UIFont(name: "Pretendard-Bold", size: 16)
        detailTitle.textAlignment = .center
        detailTitle.textColor = UIColor.init(named: "MainBlack")
    }

    private func configureButtonFunctuion() {
        likeButton.addTarget(self, action: #selector(didLikeBttonTouched(_:)), for: .touchUpInside)
    }

    @objc private func didLikeBttonTouched(_ sender: UIButton) {

    }
}
