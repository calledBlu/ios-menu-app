//
//  MenuReadyAlert.swift
//  MenuApp
//
//  Created by Blu on 2023/05/30.
//

import Foundation

struct MenuReadyAlert: AlertSendable {
    var kind = AlertKind.menuReady
    var isOn = false
    var hour = 10
    var contentTitle = "식사 준비가 시작되었습니다"
    var contentBody = "맛있는 식사를 열심히 준비 중이에요! 조금만 기다려 주세요 😁"
}
