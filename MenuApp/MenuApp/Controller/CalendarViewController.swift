//
//  CalendarViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

final class CalendarViewController: UIViewController {
    // MARK: - Properties
    private var dateProvider = DateProvider()

    // MARK: - UI Components
    private lazy var headerView = UIView()
    private lazy var calendarTitle = CalendarTitleStackView(frame: .zero)
    private lazy var weekStackView = WeekStackView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Public Methods

    // MARK: - Private Methods
}

// MARK: - UI & Layout
extension CalendarViewController {
    private func setup() {
        setUI()
        setupLayout()
    }

    private func setUI() {
        configureNavigationBar()
        calendarTitle.updateDateTitle(date: dateProvider.updateCalendarTitle())

        view.addSubview(headerView)
        view.addSubview(weekStackView)

        headerView.addSubview(calendarTitle)

    }

    private func setupLayout() {
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 70),

            calendarTitle.heightAnchor.constraint(equalToConstant: 40),
            calendarTitle.widthAnchor.constraint(equalToConstant: view.frame.size.width / 1.7),
            calendarTitle.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            calendarTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

            weekStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            weekStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weekStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weekStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func configureNavigationBar() {
        let titleLabel = UILabel(text: ViewCategory.calendar.viewTitle)

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }
}
