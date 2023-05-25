//
//  UICollectionReusableView.swift
//  MenuApp
//
//  Created by Blu on 2023/05/23.
//

import UIKit

extension UICollectionReusableView {

    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
