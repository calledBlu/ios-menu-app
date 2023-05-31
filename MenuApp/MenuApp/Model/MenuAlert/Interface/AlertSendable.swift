//
//  AlertSendable.swift
//  MenuApp
//
//  Created by Blu on 2023/05/30.
//

import Foundation

protocol AlertSendable {
    var kind: AlertKind { get }
    var isOn: Bool { get }
    var hour: Int { get }
    var contentTitle: String { get }
    var contentBody: String { get }
}
