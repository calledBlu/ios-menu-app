//
//  LikeListCell.swift
//  MenuApp
//
//  Created by Blu on 2023/05/29.
//

import UIKit

protocol LikeListCellDelegate: AnyObject {
    func updateLikeDaysList()
}

final class LikeListCell: UICollectionViewCell {
    private var likeDay: LikeDay?
    private let likeDayCoreDataManager = LikeDayCoreDataManager.shared

    var delegate: LikeListCellDelegate?

    private lazy var likeDayLabel = UILabel()
    private lazy var roundedView = UIView()
    private lazy var likeIcon = UIImageView(image: UIImage(systemName: "heart.fill"))

    private var tapLikeIconGesture: UITapGestureRecognizer?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        configureLayout()
        configureButtonFunctuion()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateLikeDay(_ likeDay: LikeDay?) {
        self.likeDay = likeDay

        let dateformatter = DateFormatter()
        dateformatter.changeFormat(to: .list)

        guard let formattedDate = likeDay?.date else {
            return
        }

        likeDayLabel.text = dateformatter.string(from: formattedDate)
    }

    private func configureUI() {
        self.addSubview(likeDayLabel)
        self.addSubview(roundedView)
        likeDayLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        likeIcon.tintColor = UIColor.init(named: "MainOrange")
        configureRoundedView()
    }

    private func configureLayout() {
        likeDayLabel.translatesAutoresizingMaskIntoConstraints = false
        likeIcon.translatesAutoresizingMaskIntoConstraints = false
        roundedView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            likeDayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeDayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            roundedView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            roundedView.widthAnchor.constraint(equalToConstant: 40),
            roundedView.heightAnchor.constraint(equalToConstant: 40),
            roundedView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            likeIcon.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            likeIcon.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor)
        ])
    }

    private func configureRoundedView() {
        roundedView.layer.cornerRadius = 20
        roundedView.layer.borderColor = UIColor.init(named: "SubGray")?.cgColor
        roundedView.layer.borderWidth = 1
        roundedView.addSubview(likeIcon)
    }

    private func configureButtonFunctuion() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didLikeBttonTouched))
        roundedView.addGestureRecognizer(tap)
        roundedView.isUserInteractionEnabled = true
    }

    @objc private func didLikeBttonTouched() {
        deleteLikeDay()
        delegate?.updateLikeDaysList()
    }

    private func deleteLikeDay() {
        guard let likeDay = likeDay?.date else {
            return
        }

        likeDayCoreDataManager.deleteLikeDay(LikeDay(date: likeDay))
    }
}
