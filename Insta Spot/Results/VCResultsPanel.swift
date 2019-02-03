//
//  VCResultsPanel.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/25/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit
import SnapLikeCollectionView
import MapKit
import UnsplashSwift

class VCResultsPanel: UIViewController {

    @IBOutlet weak var laLocationName: UILabel!
    
    @IBOutlet weak var laLocationCity: UILabel!
    
    @IBOutlet weak var laLocationMark: UILabel!
    
    @IBOutlet weak var svLocationContent: UIScrollView!
    
    @IBOutlet weak var cvLocsCollection: UICollectionView!
    
    @IBOutlet weak var cvPhotos: UICollectionView!
    
    let unsplash = Provider<Unsplash>(clientID: Constants.UnsplashSettings.clientID)
    
    var photos:[Image] = []
    
    var url = "photos/fwUvBJOG4-g"
    
    var clientid = "358bd86f2c14fc4a7fa0aab41571241aa6a0ffbef4d3109d290ffa13de9e794c"
    
    private var dataSource: SnapLikeDataSource<CVCScrollCell>?
    
    let annotation = MKPointAnnotation()
    
    var delegate:VCMainDelegate?
    
    var searchVC: VCSearchPanel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvPhotos.delegate = self
        cvPhotos.dataSource = self
        
        setupLocationsScroll()
        dataSource?.selectItem(IndexPath(item: 0, section: 0))
    }
    
    var imgURL:String?
    

    
    func setupLocationsScroll() {
        let cellSize = SnapLikeCellSize(normalWidth: 60, centerWidth: 80)
        
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
        
       
        dataSource?.items = [["rome", "Italy"],
                             ["cairo","Egypt"],
                             ["moscow", "Russia"],
                             ["new delhi", "India"]]
    }
    
   
}

extension VCResultsPanel:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cvPhotos.dequeueReusableCell(withReuseIdentifier: "PlacePhotoCell", for: indexPath)
        
        if let photoCell = cell as? CVCPhotoCell {
            photoCell.downloadPhoto()
        }
        
        return cell
    }
}

extension VCResultsPanel: SnapLikeDataDelegate {
    func cellSelected(_ index: Int) {
        DispatchQueue.main.async { [weak self] in
            let ds = (self?.dataSource)!
            self?.laLocationName.text = ds.items[index][0]
            self?.delegate?.updateMap(index:ds.items[index][0])
            self?.laLocationCity.text = ds.items[index][1]
            self?.cvLocsCollection.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally
            )
        }
    }
}
