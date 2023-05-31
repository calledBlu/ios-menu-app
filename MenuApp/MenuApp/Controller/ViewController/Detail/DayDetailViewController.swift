//
//  DayDetailViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

protocol DayDetailViewControllerDelegate: AnyObject {
    func refreshCalendarView()
}

final class DayDetailViewController: UIViewController {

    // MARK: - Properties

    private var selectDayInformation: Day?
    private var foodCoreDataManager = FoodCoreDataManager.shared
    private var selectDayFood: [Food]?
    private let dateProvider = DateProvider()
    var delegate: DayDetailViewControllerDelegate?

    // MARK: - UI Components

    private lazy var popupView = PopupView(frame: .zero)
    private var tapGestureRecognizer = UITapGestureRecognizer()

    // MARK: - Initialization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        modalPresentationStyle = .overFullScreen

    }

    convenience init(selectDayInformation: Day?) {
        self.init(nibName: nil, bundle: nil)
        self.selectDayInformation = selectDayInformation

        let menu = foodCoreDataManager.getMenu()

        dateProvider.formatter.changeFormat(to: .list)

        let cellDay = dateProvider.formatter.string(from: selectDayInformation?.date ?? Date())

        let selectedDayMenu = menu.filter { food in
            let menuDay = dateProvider.formatter.string(from: food.date)

            return menuDay == cellDay
        }

        selectDayFood = selectedDayMenu

        popupView.updateTitleAndDate(date: sendDate(), title: translateTitle())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        popupView.collectionView.delegate = self
        popupView.collectionView.dataSource = self
        popupView.buttonStackView.delegate = self
    }

    private func translateTitle() -> String {
        dateProvider.formatter.changeFormat(to: .monthAndDay)
        let weekday = dateProvider.formatter.string(from: sendDate())

        return weekday
    }

    private func sendDate() -> Date {
        guard let date = selectDayInformation?.date else {
            return Date()
        }

        return date
    }

    @objc func dismissController() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ButtonStackViewDelegate

extension DayDetailViewController: ButtonStackViewDelegate {
    func moveAddView() {
        let addMenuViewController = AddMenuViewController(menuDate: selectDayInformation?.date
        )

        addMenuViewController.modalPresentationStyle = .formSheet
        addMenuViewController.delegate = self

        self.present(addMenuViewController, animated: true)
    }

    func dismissCurrentView() {
        delegate?.refreshCalendarView()
        dismiss(animated: false)
    }
}

// MARK: - MenuDetailViewControllerDelegate

extension DayDetailViewController: MenuDetailViewControllerDelegate {
    func refreshAfterDelete() {
        let menu = foodCoreDataManager.getMenu()

        dateProvider.formatter.changeFormat(to: .list)

        let cellDay = dateProvider.formatter.string(from: selectDayInformation?.date ?? Date())

        let selectedDayMenu = menu.filter { food in
            let menuDay = dateProvider.formatter.string(from: food.date)

            return menuDay == cellDay
        }

        selectDayFood = selectedDayMenu
        popupView.collectionView.reloadData()
        configure()
    }
}

// MARK: - AddMenuViewControllerDelegate

extension DayDetailViewController: AddMenuViewControllerDelegate {
    func refreshDetailMenuList() {

        let menu = foodCoreDataManager.getMenu()

        dateProvider.formatter.changeFormat(to: .list)

        let cellDay = dateProvider.formatter.string(from: selectDayInformation?.date ?? Date())

        let selectedDayMenu = menu.filter { food in
            let menuDay = dateProvider.formatter.string(from: food.date)

            return menuDay == cellDay
        }

        selectDayFood = selectedDayMenu
        popupView.collectionView.reloadData()
        configure()
    }
}

// MARK: - UICollectionViewDelegate

extension DayDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuDetailViewController = MenuDetailViewController(food: selectDayFood?[indexPath.item])

        menuDetailViewController.modalPresentationStyle = .formSheet
        menuDetailViewController.delegate = self

        self.present(menuDetailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension DayDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return selectDayFood?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: MenuListCell.self, for: indexPath)

        cell.updateFood(food: selectDayFood?[indexPath.item])

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DayDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = popupView.frame.width

        return CGSize(width: width, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

// MARK: - UI & Layout

extension DayDetailViewController {
    private func configure() {
        configureUI()
        configureLayout()
    }

    private func configureUI() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.addSubview(popupView)
    }

    private func configureLayout() {
        popupView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            popupView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
}
