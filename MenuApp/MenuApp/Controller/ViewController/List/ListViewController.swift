//
//  ListViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: - Properties
    private let likeDayCoreDataManager = LikeDayCoreDataManager.shared
    private var likeDays: [LikeDay]?

    // MARK: - UI Components

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()

        configureNavigationBar()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell: LikeListCell.self)
        view.addSubview(collectionView)
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        likeDays = likeDayCoreDataManager.getLikeDays().sorted(by: >)
        collectionView.reloadData()
    }

    // MARK: - Private Methods

    private func configureLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 24),
            collectionView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func configureNavigationBar() {
        let titleLabel = UILabel(text: ViewCategory.list.viewTitle)

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }
}

// MARK: - UICollectionViewDelegate

extension ListViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return likeDays?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: LikeListCell.self, for: indexPath)
        cell.updateLikeDay(likeDays?[indexPath.item])
        cell.delegate = self

        return cell
    }
}

// MARK: - CalendarPickerControllerDelegate

extension ListViewController: LikeListCellDelegate {
    func updateLikeDaysList() {
        likeDays = likeDayCoreDataManager.getLikeDays().sorted(by: >)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ListViewController: UICollectionViewDelegateFlowLayout {
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
