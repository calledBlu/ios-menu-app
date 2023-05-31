//
//  UNUserNotificationCenter+Extension.swift
//  MenuApp
//
//  Created by Blu on 2023/05/30.
//

import UserNotifications

extension UNUserNotificationCenter {
    func setNotifiation(_ alert: AlertSendable) {
        let content = UNMutableNotificationContent()
        content.title = alert.contentTitle
        content.body = alert.contentBody

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = alert.hour
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let uuidString = alert.kind.description
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error)
            }
        }
    }

    func removeNotification(_ alert: AlertSendable) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification in notificationRequests {
                if notification.identifier == alert.kind.description {
                    identifiers.append(notification.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
}
