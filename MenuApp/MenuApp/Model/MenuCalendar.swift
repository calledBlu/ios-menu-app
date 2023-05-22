//
//  MenuCalendar.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import Foundation

struct MenuCalendar {
    let calendar: Calendar
    let dateFormatter: DateFormatter
    var calendarDate: Date
    var days: [String]

    init() {
        self.calendar = Calendar.current
        self.dateFormatter = DateFormatter()
        self.calendarDate = Date()
        self.days = []
    }
}
