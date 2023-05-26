//
//  DayDetailViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/26.
//

import UIKit

final class DayDetailViewController: UIViewController {

    // MARK: - UI Components

    private lazy var containerView = PopupView(frame: .zero)

    // MARK: - Initialization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
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
        view.addSubview(containerView)
    }

    private func configureLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
}
