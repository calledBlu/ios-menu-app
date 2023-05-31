//
//  DetailTitleStackView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

final class DetailTitleStackView: RoundedStackView {
    private var isFavorite = false
    private var tapLikeIconGesture: UITapGestureRecognizer?
    private let likeDayCoreDataManager = LikeDayCoreDataManager.shared
    private var titleDate: Date?

    private lazy var detailTitle = UILabel()
    private var likeIcon = UIImageView(image: UIImage(systemName: "heart"))

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureTitleView()
        configureButtonFunctuion()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateTitleAndDate(date: Date, title: String) {
        self.titleDate = date
        self.detailTitle.text = title
        updateFavoriteIcon()
    }

    private func configureTitleView() {
        configurePaddingView()
        configureTitleLabel()
        configureDivider()
        self.addArrangedSubview(likeIcon)
        likeIcon.tintColor = .init(named: "MainOrange")
        configurePaddingView()
        updateFavoriteIcon()
    }

    private func updateFavoriteIcon() {
        let dateformatter = DateFormatter()
        dateformatter.changeFormat(to: .list)

        guard let dateOfTitle = titleDate else {
            return
        }

        let likeDays = likeDayCoreDataManager.getLikeDays()
        let formattedDay = dateformatter.string(from: dateOfTitle)

        likeDays.forEach { likeDay in
            let formattedLikeDay = dateformatter.string(from: likeDay.date)
            if formattedDay == formattedLikeDay {
                likeIcon.image = UIImage(systemName: "heart.fill")
                likeIcon.tintColor = .init(named: "MainOrange")
                isFavorite = true
                return
            }
        }
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(didLikeBttonTouched))
        likeIcon.addGestureRecognizer(tap)
        likeIcon.isUserInteractionEnabled = true
    }

    @objc private func didLikeBttonTouched() {
        if isFavorite == true {
            likeIcon.image = UIImage(systemName: "heart")
            deleteLikeDay()
        } else {
            likeIcon.image = UIImage(systemName: "heart.fill")
            createLikeDay()
        }

        isFavorite.toggle()
    }

    private func createLikeDay() {
        guard let titleDate = titleDate else {
            return
        }

        let likeDay = LikeDay(date: titleDate)
        likeDayCoreDataManager.insertDay(likeDay)
        likeDayCoreDataManager.saveToContext()
    }

    private func deleteLikeDay() {
        guard let titleDate = titleDate else {
            return
        }

        let likeDay = LikeDay(date: titleDate)

        likeDayCoreDataManager.deleteLikeDay(likeDay)
    }
}
