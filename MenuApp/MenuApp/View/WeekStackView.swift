//
//  WeekStackView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import UIKit

final class WeekStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
        configureWeekLabel()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fillEqually
    }

    private func configureWeekLabel() {
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]

        dayOfTheWeek.forEach { weekday in
            let label = UILabel()
            label.text = weekday
            label.textAlignment = .center

            if weekday == "일" {
                label.textColor = .systemRed
            }

            self.addArrangedSubview(label)
        }
    }
}
