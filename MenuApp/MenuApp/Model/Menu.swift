//
//  Menu.swift
//  MenuApp
//
//  Created by Blu on 2023/05/18.
//

import Foundation

struct Menu {
    var name: String
    var category: FoodCategory
    var date: Day

    enum FoodCategory: CustomStringConvertible {
        case korean
        case chinese
        case japanese
        case western
        case fusion

        var description: String {
            switch self {
            case .korean:
                return "한식"
            case .chinese:
                return "중식"
            case .japanese:
                return "일식"
            case .western:
                return "양식"
            case .fusion:
                return "퓨전"
            }
        }
    }
}
