//
//  UIColorExtensions.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/29/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255
        let g = CGFloat((hex & 0xFF00) >> 8) / 255
        let b = CGFloat((hex & 0xFF)) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

//enum Color: [[Int]] {

    
//    case [0xFF5B50, 0xFFC950]
    
//    static func random<G: RandomNumberGenerator>(using generator: inout G) -> Color {
//        return Color.allCases.randomElement(using: &generator)!
//    }
//
//    static func random() -> Color {
//        var g = SystemRandomNumberGenerator()
//        return Color.random(using: &g)
//    }
//}
