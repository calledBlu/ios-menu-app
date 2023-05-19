//
//  ViewCategory.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import Foundation

enum ViewCategory: Int {
    case list
    case calendar
    case pushAlert

    var title: String {
        switch self {
        case .list:
            return "리스트"
        case .calendar:
            return "캘린더"
        case .pushAlert:
            return "푸시알림"
        }
    }

    var imageName: String {
        switch self {
        case .list:
            return "list.bullet.clipboard"
        case .calendar:
            return "calendar"
        case .pushAlert:
            return "bell"
        }
    }
}
