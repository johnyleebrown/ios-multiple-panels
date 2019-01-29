//
//  CVCSearchCell.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/28/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit

class CVCSearchCell: UICollectionViewCell {

    @IBOutlet weak var viSearchCell: GradientView!
   
    @IBOutlet weak var laCellTitle: UILabel!
    
    func setUp(label:String) {
        var colors = getColors()
        
        viSearchCell.translatesAutoresizingMaskIntoConstraints = false
        viSearchCell.cornerRadius = 10
        viSearchCell.topColor = UIColor(hex: colors[0])
        viSearchCell.bottomColor = UIColor(hex: colors[0])
        
        laCellTitle.text = label
        laCellTitle.adjustsFontSizeToFitWidth = true
        laCellTitle.textColor = UIColor(hex: 0xFFFFFF)
        laCellTitle.layer.zPosition = 1
    }
    
    func getColors() -> [Int]{
        var colors = [[0x64FF8F, 0x51FFEA],
                      [0xFF5B50, 0xFFC950],
                      [0x64CCF7, 0x359EEC],
                      [0xF2F23A, 0xF7A51C],
                      [0xFF28A5, 0x7934CF],
                      [0x61A8FF, 0x243BD1]]
        
        let randomInt = Int.random(in: 0..<6)
        return colors[randomInt]
    }
}
