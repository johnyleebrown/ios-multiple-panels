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
    
    @IBOutlet weak var ivImage: UIImageView!
    
    var item: [String]? {
        didSet {
            ivImage.image = UIImage(named: item![0])
        }
    }
}
