//
//  DetailTitleStackView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

final class DetailTitleStackView: RoundedStackView {
    private lazy var title = UILabel()
    private lazy var likeIcon = UIImageView(image: UIImage(systemName: "heart.fill"))

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureTitleView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateDateTitle(date: String) {
        title.text = date
    }

    private func configureTitleView() {
        configurePaddingView()
        configureTitleLabel()
        configureDivider()
        self.addArrangedSubview(likeIcon)
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
        let title = UILabel()
        self.addArrangedSubview(title)
        title.text = "04월 02일 수요일"
        title.font = UIFont(name: "Pretendard-Bold", size: 16)
        title.textAlignment = .center
        title.textColor = UIColor.init(named: "MainBlack")
    }
}
