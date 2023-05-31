//
//  CalendarPickerViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/29.
//

import UIKit

protocol CalendarPickerControllerDelegate: AnyObject {
    func updateDate(_ date: Date)
}

final class CalendarPickerViewController: UIViewController {

    // MARK: - Properties
    var delegate: CalendarPickerControllerDelegate?

    // MARK: - UI Components

    private lazy var datePicker = UIDatePicker()

    // MARK: - Initialization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    convenience init(date: Date) {
        self.init(nibName: nil, bundle: nil)
        self.datePicker.date = date
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - UI & Layout
extension CalendarPickerViewController {
    private func setup() {
        setUI()
        setupLayout()
        configureSelectButton()
    }

    private func setUI() {
        view.backgroundColor = .systemBackground
        datePicker.preferredDatePickerStyle = .inline
        datePicker.tintColor = UIColor.init(named: "MainOrange")
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.datePickerMode = .date
        view.addSubview(datePicker)
    }

    private func setupLayout() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 16
                                           ),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func configureSelectButton() {
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
    }

    @objc func changeDate() {
        delegate?.updateDate(datePicker.date)
        self.dismiss(animated: true)
    }
}
