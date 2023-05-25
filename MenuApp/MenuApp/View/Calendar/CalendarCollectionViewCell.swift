//
//  CalendarCollectionViewCell.swift
//  MenuApp
//
//  Created by Blu on 2023/05/23.
//

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
    var dayOfCell: Day? {
        didSet {
            guard let day = dayOfCell else { return }

            dayLabel.text = day.number
            configureCalendarCell()
        }
    }

    private lazy var dayLabel = UILabel()
    private lazy var likeIcon = UIImageView(image: UIImage(systemName: "heart.fill"))
    private lazy var selectionBackgroundView = CircleView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureCalendarCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureCalendarCell()
    }

    func updateDay(day: Day) {
        dayOfCell = day

        configureCalendarCell()
    }

    func changeIsSelectStatus() {
        dayLabel.textColor = .white
        self.backgroundView?.alpha = 1.0
    }

    func changeIsDeselectStatus() {
        self.backgroundView?.alpha = 0.0
        if dayOfCell?.isWithinDisplayedMonth == true {
            dayLabel.textColor = .init(named: "MainBlack")
        } else {
            dayLabel.textColor = .init(named: "SubDayGray")

        }
    }

    private func configureCalendarCell() {
        self.backgroundView = selectionBackgroundView
        self.backgroundView?.alpha = 0.0

        self.addSubview(dayLabel)
        self.addSubview(likeIcon)

        dayLabel.font = UIFont(name: "Pretendard-Bold", size: 12)

        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        likeIcon.translatesAutoresizingMaskIntoConstraints = false
        selectionBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        let size = CGFloat(25)

        selectionBackgroundView.layer.cornerRadius = size / 2

        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            likeIcon.topAnchor.constraint(equalTo: selectionBackgroundView.bottomAnchor, constant: 11),
            likeIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            likeIcon.widthAnchor.constraint(equalToConstant: self.frame.width / 4),

            selectionBackgroundView.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            selectionBackgroundView.centerXAnchor.constraint(equalTo: dayLabel.centerXAnchor),
            selectionBackgroundView.widthAnchor.constraint(equalToConstant: size),
            selectionBackgroundView.heightAnchor.constraint(equalTo: selectionBackgroundView.widthAnchor)
        ])

        likeIcon.contentMode = .scaleAspectFit
        configureItemColors()
    }

    private func configureItemColors() {
        guard let day = dayOfCell else { return }

        if day.isWithinDisplayedMonth {
            dayLabel.textColor = UIColor.init(named: "MainBlack")
            likeIcon.tintColor = UIColor.init(named: "MainOrange")
        } else {
            dayLabel.textColor = UIColor.init(named: "SubDayGray")
            likeIcon.tintColor = .clear
        }
    }
}
