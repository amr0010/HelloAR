//
//  UIColor+Extension.swift
//  HelloAR
//
//  Created by Amr Magdy on 29/10/2023.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
