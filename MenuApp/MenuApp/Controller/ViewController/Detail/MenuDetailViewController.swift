//
//  MenuDetailViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/30.
//

import UIKit

protocol MenuDetailViewControllerDelegate: AnyObject {
    func refreshAfterDelete()
}

class MenuDetailViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Properties
    private var foodCoreDataManager = FoodCoreDataManager.shared
    private var food: Food?
    private let categoryList = Food.Category.allCases
    private var foodCategory: Food.Category?
    private var tapGestureRecognizer = UITapGestureRecognizer()
    var delegate: MenuDetailViewControllerDelegate?

    // MARK: - UI Components
    private lazy var menuImageView = UIImageView()
    private lazy var navigationBar = UINavigationBar()

    private lazy var menuTitle = UILabel()
    private lazy var categoryTitle = UILabel()
    private lazy var menuTextField = UITextField()
    private lazy var categoryLabel = UILabel()

    private lazy var imagePicker = UIImagePickerController()

    // MARK: - Initialization
    convenience init(food: Food?) {
        self.init(nibName: nil, bundle: nil)

        self.food = food
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Public Methods

    // MARK: - Private Methods

}

// MARK: - UI & Layout
extension MenuDetailViewController {
    private func setup() {
        setUI()
        setupLayout()
        configureNavigationBar()
    }

    private func setUI() {
        view.addSubview(navigationBar)
        view.addSubview(menuImageView)

        view.addSubview(menuTitle)
        view.addSubview(categoryTitle)
        view.addSubview(menuTextField)
        view.addSubview(categoryLabel)

        configureMenuImageView()
        configureNavigationBar()
        configureMenuListView()
    }

    private func setupLayout() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        menuImageView.translatesAutoresizingMaskIntoConstraints = false

        menuTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        menuTextField.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            menuImageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 16),
            menuImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            menuImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            menuImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3.5),

            menuTitle.leadingAnchor.constraint(equalTo: menuImageView.leadingAnchor),
            menuTitle.topAnchor.constraint(equalTo: menuImageView.bottomAnchor, constant: 24),

            categoryTitle.leadingAnchor.constraint(equalTo: menuImageView.leadingAnchor),
            categoryTitle.topAnchor.constraint(equalTo: menuTitle.bottomAnchor, constant: 24),

            categoryLabel.leadingAnchor.constraint(equalTo: categoryTitle.trailingAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: categoryTitle.centerYAnchor),

            menuTextField.leadingAnchor.constraint(equalTo: categoryTitle.trailingAnchor),
            menuTextField.centerYAnchor.constraint(equalTo: menuTitle.centerYAnchor),
            menuTextField.trailingAnchor.constraint(equalTo: menuImageView.trailingAnchor)
        ])
    }

    private func configureMenuImageView() {
        view.backgroundColor = .systemBackground
        menuImageView.contentMode = .scaleAspectFill
        menuImageView.clipsToBounds = true
    }

    private func configureMenuListView() {
        menuTitle.text = "메뉴"
        menuTitle.font = UIFont(name: "Pretendard-Bold", size: 14)
        menuTitle.textColor = UIColor.init(named: "MainOrange")

        categoryTitle.text = "카테고리"
        categoryTitle.font = UIFont(name: "Pretendard-Bold", size: 14)
        categoryTitle.textColor = UIColor.init(named: "MainOrange")

        menuTextField.text = food?.name
        menuTextField.font = UIFont(name: "Pretendard-Regular", size: 14)

        categoryLabel.text = food?.category?.description
        categoryLabel.font = UIFont(name: "Pretendard-Regular", size: 14)

        guard let foodPhoto = food?.image else {
            return
        }

        menuImageView.image = UIImage(data: foodPhoto)

        menuImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didSelectImageViewTouched))
        menuImageView.addGestureRecognizer(tap)
    }

    @objc private func didSelectImageViewTouched() {
        self.openImagePicker()
    }

    private func configureNavigationBar() {
        let navigationItem = UINavigationItem()
        let saveButtonItem = UIBarButtonItem(title: "수정",
                                             style: .done,
                                             target: self,
                                             action: #selector(didSaveButtonTouch))
        navigationItem.setRightBarButton(saveButtonItem, animated: true)

        let deleteButtonItem = UIBarButtonItem(title: "삭제",
                                             style: .plain,
                                             target: self,
                                             action: #selector(didDeleteButtonTouch))

        navigationItem.setLeftBarButton(deleteButtonItem, animated: true)

        navigationBar.setItems([navigationItem], animated: true)
        navigationBar.tintColor = UIColor.init(named: "MainOrange")
    }

    @objc func didSaveButtonTouch() {
        // 사진, 카테고리, 이름 다른지 체크 후 다르면 생성하고 업데이트 하는 코드 넣기

        guard let food = food else {
            return
        }

        let menuPhoto = menuImageView.image?.pngData()

        if (food.name != menuTextField.text) || (food.category?.description != categoryLabel.text) || (food.image != menuPhoto) {
            let updateFood = Food(id: food.id, name: menuTextField.text ?? "", date: food.date, image: menuPhoto)
            foodCoreDataManager.updateFood(updateFood)
        }

        delegate?.refreshAfterDelete()
        self.dismiss(animated: true)
    }
    @objc func didDeleteButtonTouch() {
        guard let food = food else {
            return
        }

        foodCoreDataManager.deleteFood(food)
        delegate?.refreshAfterDelete()
        self.dismiss(animated: true)
    }
}

extension MenuDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
}

extension MenuDetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return Food.Category(rawValue: row)?.description
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        foodCategory = categoryList[row]
    }

    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))

        let categoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        categoryLabel.text = Food.Category(rawValue: row)?.description
        categoryLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        categoryLabel.textAlignment = .center

        view.addSubview(categoryLabel)

        return view
    }
}

extension MenuDetailViewController: UIImagePickerControllerDelegate {
    func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            self.menuImageView.image = image
        }

        view.bringSubviewToFront(menuImageView)
    }
}
