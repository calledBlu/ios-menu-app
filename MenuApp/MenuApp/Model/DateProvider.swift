//
//  DateProvider.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import Foundation

final class DateProvider {
    var menuCalendar = MenuCalendar()

    func configureCalendar() {
        let components = menuCalendar.calendar.dateComponents([.year, .month], from: menuCalendar.calendarDate)
        guard let newDate = menuCalendar.calendar.date(from: components) else {
            return
        }

        menuCalendar.calendarDate = newDate
        updateDays()
    }

    func updateDate(_ date: Date) {
        menuCalendar.calendarDate = date
    }

    func updateCalendarTitle() -> String {
        menuCalendar.dateFormatter.dateFormat = "YYYY년 MM월"
        return menuCalendar.dateFormatter.string(from: menuCalendar.calendarDate)
    }

    private func calculateStartWeekday() -> Int {
        return menuCalendar.calendar.component(.weekday, from: menuCalendar.calendarDate) - 1
    }

    private func calculateEndDate() -> Int {
        guard let endDate = menuCalendar.calendar.range(of: .day,
                                                        in: .month,
                                                        for: menuCalendar.calendarDate)?.count else {
            return 0
        }

        return endDate
    }

    private func updateDays() {
        menuCalendar.days.removeAll()
        let startWeekDay = calculateStartWeekday()
        let totalDays = startWeekDay + calculateEndDate()

        for day in 0..<totalDays {
            if day < startWeekDay {
                menuCalendar.days.append("")
                continue
            }
            menuCalendar.days.append("\(day - startWeekDay + 1)")
        }
    }
}
