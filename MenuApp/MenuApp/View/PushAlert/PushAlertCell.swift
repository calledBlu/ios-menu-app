//
//  PushAlertCell.swift
//  MenuApp
//
//  Created by Blu on 2023/05/30.
//

import UIKit

final class PushAlertCell: UICollectionViewCell {

    private let userNotificationCenter = UNUserNotificationCenter.current()
    private var alert: AlertKind?

    private lazy var alertTitleLabel = UILabel()
    private lazy var alertSwitch = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        alertSwitch.addTarget(self, action: #selector(alertSwitchToggle), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateAlertKind(_ kind: AlertKind) {
        self.alert = kind
        alertSwitch.isOn = UserDefaults.standard.bool(forKey: kind.description)
        configure()
    }

    private func configure() {
        configureUI()
        configureLayout()
    }

    private func configureUI() {
        self.addSubview(alertTitleLabel)
        self.addSubview(alertSwitch)
        alertTitleLabel.text = alert?.description
        alertTitleLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        alertSwitch.preferredStyle = .sliding
    }

    private func configureLayout() {
        alertTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        alertSwitch.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alertTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            alertTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            alertSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            alertSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }

    @objc func alertSwitchToggle(sender: UISwitch) {
        guard let data = alert?.data,
              let key = alert?.description else {
            return
        }

        if sender.isOn == true {
            UNUserNotificationCenter.current().setNotifiation(data)
        } else {
            UNUserNotificationCenter.current().removeNotification(data)
        }

        UserDefaults.standard.set(sender.isOn, forKey: key)
    }
}
