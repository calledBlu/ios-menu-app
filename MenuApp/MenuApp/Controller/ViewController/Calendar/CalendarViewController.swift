//
//  CalendarViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit
import CoreData

final class CalendarViewController: UIViewController {

    // MARK: - Properties

    private let dateProvider = DateProvider()
    private let likeDayCoreDataManager = LikeDayCoreDataManager.shared
    private var likeDays: [LikeDay]?
    private var defaultIndexPath: IndexPath?
    private var rightToLeftSwipeGestureRecognizer = UISwipeGestureRecognizer()
    private var leftToRightSwipeGestureRecognizer = UISwipeGestureRecognizer()

    // MARK: - UI Components

    private lazy var contentView = UIView()
    private lazy var calendarTitle = CalendarTitleStackView(frame: .zero)
    private lazy var weekStackView = WeekStackView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground

        likeDays = likeDayCoreDataManager.getLikeDays()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        likeDays = likeDayCoreDataManager.getLikeDays()
        dateProvider.updateCalendarDate(Date())
        dateProvider.selectedDate = Date()
        updateCalendar()
        collectionView.reloadData()
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
        dateProvider.formatter.changeFormat(to: .yearAndMonth)

        let date = dateProvider.formatter.string(from: dateProvider.sendCurrentCalendarDate())
        calendarTitle.updateDateTitle(date: date)
    }

    private func presentCalendarPickerController() {
        let calendarViewController = CalendarPickerViewController(date: dateProvider.sendCurrentCalendarDate())
        calendarViewController.delegate = self
        calendarViewController.modalPresentationStyle = .custom
        calendarViewController.transitioningDelegate = self
        present(calendarViewController, animated: true)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension CalendarViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
}

// MARK: - CalendarPickerControllerDelegate

extension CalendarViewController: DayDetailViewControllerDelegate {
    func refreshCalendarView() {
        likeDays = likeDayCoreDataManager.getLikeDays()
        updateCalendar()
        collectionView.reloadData()
    }
}

// MARK: - CalendarPickerControllerDelegate

extension CalendarViewController: CalendarPickerControllerDelegate {
    func updateDate(_ date: Date) {
        dateProvider.updateCalendarDate(date)
        updateCalendar()
        collectionView.reloadData()
    }
}

// MARK: - CalendarTitleStackViewDelegate

extension CalendarViewController: CalendarTitleStackViewDelegate {
    func tapPreviousMonth() {
        let previous = dateProvider.calendar.date(byAdding: DateComponents(month: -1),
                                                  to: dateProvider.sendCurrentCalendarDate())
        dateProvider.updateCalendarDate(previous)
        updateCalendar()
        collectionView.reloadData()
    }

    func tapNextMonth() {
        let next = dateProvider.calendar.date(byAdding: DateComponents(month: 1),
                                              to: dateProvider.sendCurrentCalendarDate())
        dateProvider.updateCalendarDate(next)
        updateCalendar()
        collectionView.reloadData()
    }

    func tapTitle() {
        presentCalendarPickerController()
    }
}

// MARK: - UICollectionViewDelegate

extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: CalendarCollectionViewCell.self, for: indexPath)
        let daysInMonth = dateProvider.sendDaysInMonth()

        cell.updateDay(day: daysInMonth[indexPath.item])
        cell.checkIsFavorite(likeDays: likeDays)

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

        let daysInMonth = dateProvider.sendDaysInMonth()
        dateProvider.selectedDate = daysInMonth[indexPath.item].date

        if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
            cell.changeIsSelectStatus()

            dateProvider.updateCalendarDate(daysInMonth[indexPath.item].date)
            let dayDetailViewContriller = DayDetailViewController(selectDayInformation: daysInMonth[indexPath.item])
            dayDetailViewContriller.delegate = self
            self.present(dayDetailViewContriller, animated: false)
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
        configurePanGesture()
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
            collectionView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),

            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
    }

    private func configurePanGesture() {
        rightToLeftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(moveNextMonth))
        rightToLeftSwipeGestureRecognizer.direction = .left
        collectionView.addGestureRecognizer(rightToLeftSwipeGestureRecognizer)

        leftToRightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(movePreviousMonth))
        leftToRightSwipeGestureRecognizer.direction = .right
        collectionView.addGestureRecognizer(leftToRightSwipeGestureRecognizer)
    }

    private func configureNavigationBar() {
        let titleLabel = UILabel(text: ViewCategory.calendar.viewTitle)

        let leftBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItems = [leftBarButton]
    }

    @objc func movePreviousMonth() {
        tapPreviousMonth()
    }

    @objc func moveNextMonth() {
        tapNextMonth()
    }
}
