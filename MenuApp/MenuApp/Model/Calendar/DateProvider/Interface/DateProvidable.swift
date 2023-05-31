//
//  DateProvidable.swift
//  MenuApp
//
//  Created by Blu on 2023/05/25.
//

import Foundation

protocol DateProvidable {
    var calendar: Calendar { get }
    var selectedDate: Date { get }

    func generateMonthMetaData(for baseDate: Date) throws -> MonthMetadata
    func generateDaysInMonth(for baseDate: Date) throws -> [Day]
    func generateStartOfNextMonth(for firstDayOfDisplayedMonth: Date) -> [Day]
    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day
}

extension DateProvidable {
    func generateMonthMetaData(for baseDate: Date) throws -> MonthMetadata {
        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month],
                                                                                from: baseDate)),
              let month = calendar.date(from: calendar.dateComponents([.month], from: baseDate)) else {
            throw CalendarDataError.doNotGenerateMetaData
        }

        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)

        return MonthMetadata(numberOfDays: numberOfDaysInMonth,
                             firstDay: firstDayOfMonth,
                             firstWeekday: firstDayWeekday,
                             month: month)
    }

    func generateDaysInMonth(for baseDate: Date) throws -> [Day] {
        guard let monthMetaData = try? generateMonthMetaData(for: baseDate) else {
            throw CalendarDataError.doNotGenerateMetaData
        }

        let numberOfDaysInMonth = monthMetaData.numberOfDays
        let offsetInInitialRow = monthMetaData.firstWeekday
        let firstDayOfMonth = monthMetaData.firstDay

        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow)).map { day in
            let isWithinDisplayedMonth = day >= offsetInInitialRow
            let dayOffset = isWithinDisplayedMonth ? day - offsetInInitialRow : -(offsetInInitialRow - day)

            return generateDay(offsetBy: dayOffset,
                               for: firstDayOfMonth,
                               isWithinDisplayedMonth: isWithinDisplayedMonth)
        }

        days += generateStartOfNextMonth(for: firstDayOfMonth)

        return days
    }

    func generateStartOfNextMonth(for firstDayOfDisplayedMonth: Date) -> [Day] {
        guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1),
                                                 to: firstDayOfDisplayedMonth) else {
            return []
        }

        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)

        if additionalDays == 0 {
            return []
        }

        let days: [Day] = (1...additionalDays).map {
            generateDay(offsetBy: $0, for: lastDayInMonth, isWithinDisplayedMonth: false)
        }

        return days
    }

    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
        let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate
        let dateFormatter = DateFormatter()
        dateFormatter.changeFormat(to: .day)

        return Day(date: date,
                   number: dateFormatter.string(from: date),
                   isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                   isWithinDisplayedMonth: isWithinDisplayedMonth)
    }
}
