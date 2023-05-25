//
//  CalendarDateFormat.swift
//  MenuApp
//
//  Created by Blu on 2023/05/25.
//

import Foundation

enum CalendarDateFormat {
    case yearAndMonth
    case day

    var format: String {
        switch self {
        case .yearAndMonth:
            return "YYYY년 MM월"
        case .day:
            return "d"
        }
    }
}
