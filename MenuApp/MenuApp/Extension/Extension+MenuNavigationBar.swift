//
//  Extension+MenuNavigationBar.swift
//  MenuApp
//
//  Created by Blu on 2023/05/20.
//

import UIKit

extension MenuNavigationBar: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
