//
//  VCResultsPanel.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/25/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit
import SnapLikeCollectionView

class VCResultsPanel: UIViewController {

    @IBOutlet weak var laLocationName: UILabel!
    
    @IBOutlet weak var laLocationCity: UILabel!
    
    @IBOutlet weak var laLocationMark: UILabel!
    
    @IBOutlet weak var svLocationContent: UIScrollView!
    
    @IBOutlet weak var cvLocsCollection: UICollectionView!
    
    private var dataSource: SnapLikeDataSource<CVCScrollCell>?
    
    //
    //
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationsScroll()
    }

    //
    //
    //
    
    func setupLocationsScroll() {
        let cellSize = SnapLikeCellSize(normalWidth: 100, centerWidth: 160)
        
        dataSource = SnapLikeDataSource<CVCScrollCell>(collectionView: cvLocsCollection, cellSize: cellSize)
        dataSource?.delegate = self
        
        let layout = SnapLikeCollectionViewFlowLayout(cellSize: cellSize)
        cvLocsCollection.collectionViewLayout = layout
        
        cvLocsCollection.registerNib(CVCScrollCell.self)
        cvLocsCollection.showsHorizontalScrollIndicator = false
        cvLocsCollection.decelerationRate = .fast
        cvLocsCollection.backgroundColor = .clear
        cvLocsCollection.delegate = dataSource
        cvLocsCollection.dataSource = dataSource
        
        dataSource?.items = ["A", "B", "C", "D", "E"]
    }
}

extension VCResultsPanel: SnapLikeDataDelegate {
    func cellSelected(_ index: Int) {
        DispatchQueue.main.async { [weak self] in
            let selectedItem: String = self?.dataSource?.items[index] ?? ""
            self?.laLocationName.text = selectedItem
        }
    }
}

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ cellType: T.Type){
        let nibName = String(describing: cellType)
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
}
