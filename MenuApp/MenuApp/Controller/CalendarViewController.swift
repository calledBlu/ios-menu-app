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
    private var defaultIndexPath: IndexPath?

    // MARK: - UI Components

    private lazy var contentView = UIView()
    private lazy var calendarTitle = CalendarTitleStackView(frame: .zero)
    private lazy var weekStackView = WeekStackView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground

        configure()
        updateCalendar()
    }

    // MARK: - Private Methods

    private func updateCalendar() {
        let metaData = try? dateProvider.generateMonthMetaData(for: dateProvider.sendCurrentCalendarDate())
        let newDays = try? dateProvider.generateDaysInMonth(for: dateProvider.sendCurrentCalendarDate())

        dateProvider.configureMonthMetaData(metaData)
        dateProvider.updateDaysInMonth(newDays)

        updateTitle()
    }

    private func configurationDelegateAndFunction() {
        collectionView.dataSource = self
        collectionView.delegate = self
        calendarTitle.delegate = self
    }

    private func updateTitle() {
        let date = dateProvider.titleDateFormatter.string(from: dateProvider.sendCurrentCalendarDate())
        calendarTitle.updateDateTitle(date: date)
    }
}

// MARK: - UICollectionViewDelegate

extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: CalendarCollectionViewCell.self, for: indexPath)
        let daysInMonth = dateProvider.sendDaysInMonth()

        cell.updateDay(day: daysInMonth[indexPath.item])

        if daysInMonth[indexPath.item].isSelected == true {
            cell.changeIsSelectStatus()
            defaultIndexPath = indexPath
        }
        dateProvider.updateDaysInMonth(with: indexPath, value: false)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let defaultCell = collectionView.cellForItem(at: defaultIndexPath!) as? CalendarCollectionViewCell {
            defaultCell.changeIsDeselectStatus()
        }

        if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
            cell.changeIsSelectStatus()

            self.present(DayDetailViewController(), animated: false)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
            cell.changeIsDeselectStatus()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.weekStackView.frame.width / 7
        let height = collectionView.frame.height
        let collectionViewHeight = dateProvider.sendDaysInMonth().count == 35 ? (height / 5) : (height / 5.5)

        return CGSize(width: width, height: collectionViewHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

// MARK: - CalendarTitleStackViewDelegate

extension CalendarViewController: CalendarTitleStackViewDelegate {
    func movePreviousMonth() {
        let previous = dateProvider.calendar.date(byAdding: DateComponents(month: -1),
                                                  to: dateProvider.sendCurrentCalendarDate())
        dateProvider.updateCalendarDate(previous)
        updateCalendar()
        collectionView.reloadData()
    }

    func moveNextMonth() {
        let next = dateProvider.calendar.date(byAdding: DateComponents(month: 1),
                                              to: dateProvider.sendCurrentCalendarDate())
        dateProvider.updateCalendarDate(next)
        updateCalendar()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateProvider.sendDaysInMonth().count
    }
}

// MARK: - UI & Layout

extension CalendarViewController {
    private func configure() {
        configureNavigationBar()
        configureUI()
        configureLayout()
        configurationDelegateAndFunction()
    }

    private func configureUI() {
        view.addSubview(contentView)
        contentView.addSubview(calendarTitle)
        contentView.addSubview(weekStackView)
        contentView.addSubview(collectionView)

        collectionView.register(cell: CalendarCollectionViewCell.self)
    }

    private func configureLayout() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 49),

            calendarTitle.heightAnchor.constraint(equalToConstant: 40),
            calendarTitle.widthAnchor.constraint(equalToConstant: view.frame.size.width / 1.7),
            calendarTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            calendarTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            weekStackView.topAnchor.constraint(equalTo: calendarTitle.bottomAnchor, constant: 20),
            weekStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weekStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: weekStackView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView
                .bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),

            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
    }

    private func configureNavigationBar() {
        let titleLabel = UILabel(text: ViewCategory.calendar.viewTitle)

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }
}
