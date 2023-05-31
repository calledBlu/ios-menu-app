//
//  MenuStartAlert.swift
//  MenuApp
//
//  Created by Blu on 2023/05/30.
//

import Foundation

struct MenuStartAlert: AlertSendable {
    var kind = AlertKind.menuStart
    var isOn = false
    var hour = 12
    var contentTitle = "식사 시작 시간입니다"
    var contentBody = "맛있는 식사가 모두 준비되었어요! 맛있게 드세요 😋"
}
