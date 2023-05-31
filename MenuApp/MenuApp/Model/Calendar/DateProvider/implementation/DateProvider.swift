//
//  DateProvider.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import Foundation

final class DateProvider: DateProvidable {

    // MARK: - Properties

    private var menuCalendar = MenuCalendar()
    private var monthMetaData: MonthMetadata?

    let calendar: Calendar
    let formatter: DateFormatter
    let selectedDate = Date()

    // MARK: - Initialization

    init() {
        self.calendar = Calendar(identifier: .gregorian)
        self.formatter = DateFormatter()
        self.formatter.setLocaleKoKr()
    }

    // MARK: - Public Methods

    func configureMonthMetaData(_ data: MonthMetadata?) {
        monthMetaData = data
    }

    func updateDaysInMonth(_ newDays: [Day]?) {
        guard let newDays = newDays else {
            return
        }

        menuCalendar.daysInMonth = newDays
    }

    func sendCurrentCalendarDate() -> Date {
        return menuCalendar.calendarDate
    }

    func sendMonthDate() -> Date? {
        return monthMetaData?.month
    }

    func updateCalendarDate(_ date: Date?) {
        guard let date = date else {
            return
        }

        menuCalendar.calendarDate = date
    }

    func sendDaysInMonth() -> [Day] {
        guard let daysInMonth = menuCalendar.daysInMonth else {
            return []
        }
        return daysInMonth
    }

    func updateDaysInMonth(with index: IndexPath, value: Bool) {
        menuCalendar.daysInMonth?[index.item].isSelected = value
    }

    // MARK: - Private Methods

    private func startDayOfTheWeek() -> Int {
        return calendar.component(.weekday, from: menuCalendar.calendarDate) - 1
    }

    private func endDate() -> Int {
        return calendar.range(of: .day, in: .month, for: menuCalendar.calendarDate)?.count ?? Int()
    }
}
