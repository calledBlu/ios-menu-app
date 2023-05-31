//
//  MenuListCell.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

final class MenuListCell: UICollectionViewCell {

    private var food: Food?

    private lazy var menuListCellView = MenuListCellView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(menuListCellView)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            menuListCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            menuListCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            menuListCellView.topAnchor.constraint(equalTo: self.topAnchor),
            menuListCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func updateFood(food: Food?) {
        self.food = food

        guard let updatedFood = food else {
            return
        }

        menuListCellView.updateFoodCellView(food: updatedFood)
    }
}
