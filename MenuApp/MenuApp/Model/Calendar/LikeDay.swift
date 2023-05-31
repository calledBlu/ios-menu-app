//
//  LikeDay.swift
//  MenuApp
//
//  Created by Blu on 2023/05/28.
//

import Foundation

struct LikeDay: Comparable {
    let date: Date

    static func < (lhs: LikeDay, rhs: LikeDay) -> Bool {
        return lhs.date < rhs.date
    }

    static func > (lhs: LikeDay, rhs: LikeDay) -> Bool {
        return lhs.date > rhs.date
    }
}
