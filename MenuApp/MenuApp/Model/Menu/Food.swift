//
//  Menu.swift
//  MenuApp
//
//  Created by Blu on 2023/05/18.
//

import Foundation

struct Food {
    let id: UUID
    var name: String
    var category: Category?
    var date: Date
    var image: Data?

    enum Category: Int, CustomStringConvertible, CaseIterable {
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

        var color: String {
            switch self {
            case .korean:
                return "CategoryPink"
            case .chinese:
                return "CategoryOrange"
            case .japanese:
                return "CategoryGray"
            case .western:
                return "CategoryDarkGray"
            case .fusion:
                return "CategoryCoral"
            }
        }
    }
}
