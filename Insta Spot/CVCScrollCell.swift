//
//  CVCScrollCell.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/25/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit
import SnapLikeCollectionView

class CVCScrollCell: UICollectionViewCell, SnapLikeCell{
    
//    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
//            bgView.layer.backgroundColor = (UIColor.black.withAlphaComponent(0.2) as! CGColor)
            bgView.layer.cornerRadius = 32
        }
    }
    
    @IBOutlet weak var laTitle: UILabel!
    
    var item: String? {
        didSet {
            laTitle.text = item!
        }
    }
}
