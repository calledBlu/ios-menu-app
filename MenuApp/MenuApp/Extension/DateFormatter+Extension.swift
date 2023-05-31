//
//  DateFormatter+Extension.swift
//  MenuApp
//
//  Created by Blu on 2023/05/27.
//

import Foundation

extension DateFormatter {

    func setLocaleKoKr() {
        self.locale = Locale(identifier: "ko_KR")
    }

    func changeFormat(to type: CalendarDateFormat) {
        switch type {
        case .yearAndMonth:
            self.dateFormat = type.format
        case .day:
            self.dateFormat = type.format
        case .monthAndDay:
            self.dateFormat = type.format
        case .list:
            self.dateFormat = type.format
        }
    }
}
