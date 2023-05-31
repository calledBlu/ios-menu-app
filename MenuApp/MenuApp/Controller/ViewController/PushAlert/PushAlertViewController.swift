//
//  PushAlertViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

final class PushAlertViewController: UIViewController {

    // MARK: - Properties
    private let alertKind = AlertKind.allCases

    // MARK: - UI Components
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        setup()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: PushAlertCell.self)
    }

    // MARK: - Private Methods

    private func configureNavigationBar() {
        let titleLabel = UILabel(text: ViewCategory.pushAlert.viewTitle)
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 18)

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }
}

// MARK: - UICollectionViewDataSource

extension PushAlertViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return alertKind.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: PushAlertCell.self, for: indexPath)
        cell.updateAlertKind(alertKind[indexPath.item])

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PushAlertViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = 40.0

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

// MARK: - UI & Layout
extension PushAlertViewController {
    private func setup() {
        setUI()
        setupLayout()
    }

    private func setUI() {
        view.addSubview(collectionView)
    }

    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 24),
            collectionView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
