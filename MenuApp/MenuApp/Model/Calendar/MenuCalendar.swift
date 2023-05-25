//
//  MenuCalendar.swift
//  MenuApp
//
//  Created by Blu on 2023/05/22.
//

import Foundation

struct MenuCalendar {
    var calendarDate: Date
    var daysInMonth: [Day]?

    init() {
        self.calendarDate = Date()
        self.daysInMonth = []
    }
}
