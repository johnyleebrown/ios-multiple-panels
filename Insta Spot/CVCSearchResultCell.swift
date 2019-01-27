//
//  CVCSearchResultCell.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/27/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit

class CVCSearchResultCell: UICollectionViewCell {

    @IBOutlet weak var viSearchResultCellView: UIView!
    
    @IBOutlet weak var laSearchResultCellLabel: UILabel!
    
//    private lazy var momentumView: GradientView = {
//        let view = GradientView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor(white: 0.3, alpha: 1)
//        view.topColor = UIColor(hex: 0x61A8FF)
//        view.bottomColor = UIColor(hex: 0x243BD1)
//        view.cornerRadius = 30
//        return view
//    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let viSearchResultCellView = GradientView()
        viSearchResultCellView.translatesAutoresizingMaskIntoConstraints = false
        viSearchResultCellView.backgroundColor = UIColor(white: 0.3, alpha: 1)
        viSearchResultCellView.topColor = UIColor(hex: 0x61A8FF)
        viSearchResultCellView.bottomColor = UIColor(hex: 0x243BD1)
        viSearchResultCellView.cornerRadius = 30
    }

}
