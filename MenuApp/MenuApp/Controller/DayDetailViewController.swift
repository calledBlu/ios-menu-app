//
//  DayDetailViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

final class DayDetailViewController: UIViewController {

    // MARK: - Properties
    private let dateProvider = DateProvider()
    private var selectDayInformation: Day?

    // MARK: - UI Components

    private lazy var popupView = PopupView(frame: .zero)

    // MARK: - Initialization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        modalPresentationStyle = .overFullScreen
    }

    convenience init(selectDayInformation: Day?) {
        self.init(nibName: nil, bundle: nil)
        self.selectDayInformation = selectDayInformation
        popupView.updateTitle(translateTitle())
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
        guard let date = selectDayInformation?.date else {
            return ""
        }

        let weekday = dateProvider.detailTitleDateFormatter.string(from: date)

        return weekday
    }
}

extension DayDetailViewController: ButtonStackViewDelegate {
    func moveAddView() {
        // 새 뷰컨 추가 예정
    }

    func dismissCurrentView() {
        dismiss(animated: false)
    }
}

// MARK: - UICollectionViewDelegate

extension DayDetailViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension DayDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: MenuListCell.self, for: indexPath)
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
