//
//  UICollectionViewExtensions.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/29/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ cellType: T.Type){
        let nibName = String(describing: cellType)
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
}
