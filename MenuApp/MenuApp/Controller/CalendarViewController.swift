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
    private lazy var calendarTitle = RoundedStackView(frame: .zero)
    private lazy var previousButton = UIButton(systemName: "chevron.left")
    private lazy var nextButton = UIButton(systemName: "chevron.right")

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
        configureTitleView()
    }

    private func setupLayout() {
        configureHeaderViewLayout()
        configureTitleLayout()
    }

    private func configureNavigationBar() {
        let titleLabel = UILabel(text: ViewCategory.calendar.viewTitle)

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }

    private func configureHeaderViewLayout() {
        view.addSubview(headerView)

        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func configureTitleLayout() {
        headerView.addSubview(calendarTitle)

        NSLayoutConstraint.activate([
            calendarTitle.heightAnchor.constraint(equalToConstant: 40),
            calendarTitle.widthAnchor.constraint(equalToConstant: view.frame.size.width / 1.7),
            calendarTitle.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            calendarTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }

    private func configureTitleView() {
        configurePaddingView()
        calendarTitle.addArrangedSubview(previousButton)
        configureDivider()
        configureTitleLabel()
        configureDivider()
        calendarTitle.addArrangedSubview(nextButton)
        configurePaddingView()
    }

    private func configurePaddingView() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: calendarTitle.frame.size.width / 5, height: 0))
        calendarTitle.addArrangedSubview(paddingView)
    }

    private func configureDivider() {
        let divider = UIView()
        divider.backgroundColor = .lightGray

        calendarTitle.addArrangedSubview(divider)

        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.centerYAnchor.constraint(equalTo: calendarTitle.centerYAnchor),
            divider.heightAnchor.constraint(equalTo: calendarTitle.heightAnchor, multiplier: 0.4)
        ])
    }

    private func configureTitleLabel() {
        let title = UILabel()
        calendarTitle.addArrangedSubview(title)
        title.text = dateProvider.updateCalendarTitle()
        title.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        title.textAlignment = .center
    }
}
