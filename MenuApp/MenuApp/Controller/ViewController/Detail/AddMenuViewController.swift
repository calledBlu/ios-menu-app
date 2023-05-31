//
//  AddMenuViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/29.
//

import UIKit

protocol AddMenuViewControllerDelegate: AnyObject {
    func refreshDetailMenuList()
}

class AddMenuViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Properties
    private var foodCoreDataManager = FoodCoreDataManager.shared
    private var menuDate: Date?
    private let categoryList = Food.Category.allCases
    private var foodCategory: Food.Category?
    private var tapGestureRecognizer = UITapGestureRecognizer()
    var delegate: AddMenuViewControllerDelegate?

    // MARK: - UI Components
    private lazy var selectImageLabel = UILabel()
    private lazy var selectImageView = UILabel()
    private lazy var menuImageView = UIImageView()
    private lazy var navigationBar = UINavigationBar()

    private lazy var menuTitle = UILabel()
    private lazy var categoryTitle = UILabel()
    private lazy var menuTextField = UITextField()
    private lazy var categoryPicker = UIPickerView()

    private lazy var imagePicker = UIImagePickerController()

    // MARK: - Initialization
    convenience init(menuDate: Date?) {
        self.init(nibName: nil, bundle: nil)

        self.menuDate = menuDate
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        categoryPicker.dataSource = self
        categoryPicker.delegate = self
    }

    // MARK: - Public Methods

    // MARK: - Private Methods

}

// MARK: - UI & Layout
extension AddMenuViewController {
    private func setup() {
        setUI()
        setupLayout()
        configureNavigationBar()
    }

    private func setUI() {
        view.addSubview(navigationBar)
        view.addSubview(menuImageView)
        view.addSubview(selectImageView)
        selectImageView.addSubview(selectImageLabel)

        view.addSubview(menuTitle)
        view.addSubview(categoryTitle)
        view.addSubview(menuTextField)
        view.addSubview(categoryPicker)

        configureMenuImageView()
        configureNavigationBar()
        configureMenuListView()
    }

    private func setupLayout() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        selectImageView.translatesAutoresizingMaskIntoConstraints = false
        selectImageLabel.translatesAutoresizingMaskIntoConstraints = false

        menuTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        menuTextField.translatesAutoresizingMaskIntoConstraints = false
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            menuImageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 16),
            menuImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            menuImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            menuImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3.5),

            selectImageView.topAnchor.constraint(equalTo: menuImageView.topAnchor),
            selectImageView.bottomAnchor.constraint(equalTo: menuImageView.bottomAnchor),
            selectImageView.leadingAnchor.constraint(equalTo: menuImageView.leadingAnchor),
            selectImageView.trailingAnchor.constraint(equalTo: menuImageView.trailingAnchor),

            selectImageLabel.centerXAnchor.constraint(equalTo: selectImageView.centerXAnchor),
            selectImageLabel.centerYAnchor.constraint(equalTo: selectImageView.centerYAnchor),

            menuTitle.leadingAnchor.constraint(equalTo: menuImageView.leadingAnchor),
            menuTitle.topAnchor.constraint(equalTo: menuImageView.bottomAnchor, constant: 24),

            categoryTitle.leadingAnchor.constraint(equalTo: menuImageView.leadingAnchor),
            categoryTitle.topAnchor.constraint(equalTo: menuTitle.bottomAnchor, constant: 24),
            categoryTitle.trailingAnchor.constraint(equalTo: selectImageLabel.leadingAnchor),

            categoryPicker.leadingAnchor.constraint(equalTo: categoryTitle.trailingAnchor),
            categoryPicker.centerYAnchor.constraint(equalTo: categoryTitle.centerYAnchor),
            categoryPicker.trailingAnchor.constraint(equalTo: menuTextField.trailingAnchor),

            menuTextField.leadingAnchor.constraint(equalTo: categoryTitle.trailingAnchor),
            menuTextField.centerYAnchor.constraint(equalTo: menuTitle.centerYAnchor),
            menuTextField.trailingAnchor.constraint(equalTo: menuImageView.trailingAnchor)
        ])
    }

    private func configureMenuImageView() {
        view.backgroundColor = .systemBackground
        menuImageView.contentMode = .scaleAspectFill
        menuImageView.clipsToBounds = true
        selectImageView.roundCorners(cornerRadius: 10,
                                     maskedCorners: [.layerMaxXMaxYCorner,
                                                     .layerMaxXMinYCorner,
                                                     .layerMinXMaxYCorner,
                                                     .layerMinXMinYCorner])
        selectImageView.layer.borderColor = UIColor.init(named: "SubGray")?.cgColor
        selectImageView.layer.borderWidth = 0.5
        selectImageLabel.text = "사진을 업로드하려면 터치하세요."

        selectImageLabel.textColor = UIColor.init(named: "MainOrange")
        selectImageLabel.textAlignment = .center
        selectImageLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
    }

    private func configureMenuListView() {
        menuTitle.text = "메뉴"
        menuTitle.font = UIFont(name: "Pretendard-Bold", size: 14)
        menuTitle.textColor = UIColor.init(named: "MainOrange")

        categoryTitle.text = "카테고리"
        categoryTitle.font = UIFont(name: "Pretendard-Bold", size: 14)
        categoryTitle.textColor = UIColor.init(named: "MainOrange")

        menuTextField.placeholder = "메뉴명을 입력해 주세요."
        menuTextField.font = UIFont(name: "Pretendard-Regular", size: 14)
        menuTextField.borderStyle = .roundedRect

        view.bringSubviewToFront(menuTextField)
        selectImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didSelectImageViewTouched))
        selectImageView.addGestureRecognizer(tap)
    }

    @objc private func didSelectImageViewTouched() {
        self.openImagePicker()
    }

    private func configureNavigationBar() {
        let saveButtonItem = UIBarButtonItem(title: "저장",
                                             style: .done,
                                             target: self,
                                             action: #selector(didSaveButtonTouch))
        let navigationItem = UINavigationItem()
        navigationItem.setRightBarButton(saveButtonItem, animated: true)

        navigationBar.setItems([navigationItem], animated: true)
        navigationBar.tintColor = UIColor.init(named: "MainOrange")
    }

    @objc func didSaveButtonTouch() {
        guard let menuName = menuTextField.text else {
            return
        }
        let category = foodCategory
        let menuPhoto = menuImageView.image?.pngData()

        if menuName != "" {
            let menu = Food(id: UUID(), name: menuName,
                            category: category,
                            date: menuDate ?? Date(),
                            image: menuPhoto)

            foodCoreDataManager.insertFood(menu)
            foodCoreDataManager.saveToContext()
        }
        delegate?.refreshDetailMenuList()
        self.dismiss(animated: true)
    }
}

extension AddMenuViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
}

extension AddMenuViewController: UIPickerViewDelegate {
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

extension AddMenuViewController: UIImagePickerControllerDelegate {
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
