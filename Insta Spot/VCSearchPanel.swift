//
//  VCSearchPanel.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/27/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit

class VCSearchPanel: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var cvSearchResults: UICollectionView!
    
    var listOfCities = [City]()
    
    var filtteredCities = [City]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfCities.append(City(title:"moscow"))
        listOfCities.append(City(title:"new delhi"))
        listOfCities.append(City(title:"rome"))
        listOfCities.append(City(title:"cairo"))
    
        cvSearchResults.registerNib(CVCSearchCell.self)
        cvSearchResults.delegate = self
        cvSearchResults.dataSource = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
}

extension VCSearchPanel:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContent(searchText: searchText)
    }
    
    func filterContent(searchText:String) {
        filtteredCities = listOfCities.filter({(city:City) -> Bool in
            return (city.title?.lowercased().contains(searchText.lowercased()))!
        })
        cvSearchResults.reloadData()
    }
}

extension VCSearchPanel:UICollectionViewDelegate {
    
}

extension VCSearchPanel:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtteredCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CVCSearchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCSearchCell", for: indexPath) as! CVCSearchCell
        
        cell.setUp(label: filtteredCities[indexPath.row].title!)
        
        return cell
    }
}

class City: NSObject {
    var title:String?
    
    init(title:String) {
        self.title = title
    }
}

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ cellType: T.Type){
        let nibName = String(describing: cellType)
        print(nibName)
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
}
