//
//  MenuListCellView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

final class MenuListCellView: UIView {
    private var foodCoreDataManager = FoodCoreDataManager.shared

    private lazy var photo = UIImageView()
    private lazy var menuName = UILabel()
    private lazy var category = CircleView(frame: .zero)
    private lazy var categoryLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateFoodCellView(food: Food) {
        guard let image = food.image,
              let foodCategory = food.category?.rawValue else {
            return
        }

        photo.image = UIImage(data: image)
        menuName.text = food.name
        categoryLabel.text = Food.Category(rawValue: foodCategory)?.description
        category.backgroundColor = .init(named: Food.Category(rawValue: foodCategory)?.color ?? "SubGray")
    }

    private func configure() {
        configureUI()
        configureLayout()
    }

    private func configureUI() {
        self.addSubview(photo)
        self.addSubview(menuName)
        self.addSubview(category)
        category.addSubview(categoryLabel)
        category.layer.cornerRadius = 15

        photo.image = UIImage(systemName: "photo.fill")
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true

        menuName.text = "맛있는 코드"
        menuName.textAlignment = .natural
        menuName.font = UIFont(name: "Pretendard-Regular", size: 14)

        category.backgroundColor = .init(named: "SubGray")

        categoryLabel.text = "한식"
        categoryLabel.textAlignment = .center
        categoryLabel.textColor = .white
        categoryLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
    }

    private func configureLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        photo.translatesAutoresizingMaskIntoConstraints = false
        menuName.translatesAutoresizingMaskIntoConstraints = false
        category.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photo.widthAnchor.constraint(equalToConstant: 40),
            photo.heightAnchor.constraint(equalToConstant: 40),
            photo.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            menuName.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 12),
            menuName.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            category.widthAnchor.constraint(equalToConstant: 53),
            category.heightAnchor.constraint(equalToConstant: 32),
            category.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            category.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            categoryLabel.leadingAnchor.constraint(equalTo: menuName.trailingAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: category.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: category.centerYAnchor)
        ])
    }
}
