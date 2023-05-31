//
//  Day.swift
//  MenuApp
//
//  Created by Blu on 2023/05/23.
//

import Foundation

struct Day {
    let date: Date
    let number: String
    var isSelected: Bool
    let isWithinDisplayedMonth: Bool
    var isFavorite: Bool?

    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.changeFormat(to: .day)

        date = Date()
        number = dateFormatter.string(from: Date())
        isSelected = true
        isWithinDisplayedMonth = true
        isFavorite = false
    }

    init(date: Date, number: String, isSelected: Bool, isWithinDisplayedMonth: Bool) {
        self.date = date
        self.number = number
        self.isSelected = isSelected
        self.isWithinDisplayedMonth = isWithinDisplayedMonth
        self.isFavorite = false
    }
}
