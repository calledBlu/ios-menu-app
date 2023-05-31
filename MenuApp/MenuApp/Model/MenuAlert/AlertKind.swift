//
//  AlertKind.swift
//  MenuApp
//
//  Created by Blu on 2023/05/30.
//

import Foundation

enum AlertKind: CustomStringConvertible, CaseIterable {
    case menuReady
    case menuStart

    var description: String {
        switch self {
        case .menuReady:
            return "식사 준비"
        case .menuStart:
            return "식사 시작"
        }
    }

    var data: AlertSendable {
        switch self {
        case .menuReady:
            return MenuReadyAlert()
        case .menuStart:
            return MenuStartAlert()
        }
    }
}
