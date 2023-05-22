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

    var barTitle: String {
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

    var viewTitle: String {
        switch self {
        case .list:
            return "저장된 날짜 리스트"
        case .calendar:
            return "주식회사 블루 식단표"
        case .pushAlert:
            return "푸시 알림 설정"
        }
    }
}
