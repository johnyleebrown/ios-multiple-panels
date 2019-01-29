//
//  VCSearchPanel.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/27/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit
import FloatingPanel

class VCSearchPanel: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var cvSearchResults: UICollectionView!
    
    var listOfCities = [City]()
    
    var filtteredCities = [City]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var mainDelegate:VCMainDelegate?
    
    var resultDelegate:VCResultsPanel?

    let dict: Dictionary = ["rome":[41.902782, 12.496366],
                            "cairo":[30.045322, 31.239624],
                            "moscow":[55.751244, 37.618423],
                            "new delhi":[28.644800, 77.216721]]
    
    let dictAr = ["rome", "cairo","moscow","new delhi"]
    
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
            return (city.title.lowercased().contains(searchText.lowercased()))
        })
        cvSearchResults.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("searchBarSearchButtonClicked")
        self.view.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        print("searchBarTextDidBeginEditing")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        
        if mainDelegate?.getPanelPosition(name: "search") == FloatingPanelPosition.tip {
            
            mainDelegate?.setPanel(panel: "search", position: FloatingPanelPosition.full)
        }
        
        return true
    }
    
    
}

extension VCSearchPanel:UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtteredCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CVCSearchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCSearchCell", for: indexPath) as! CVCSearchCell
        
        cell.setUp(label: filtteredCities[indexPath.row].title)
        
        return cell
    }
    
    
//    func indexOfQuestion(id: Int) -> Int {
//        return dict.indexOf { (question) -> Bool in
//            return question["quesID"] as? Int == id
//            } ?? NSNotFound
//    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        mainDelegate?.setPanel(panel: "search", position: FloatingPanelPosition.tip)
        mainDelegate?.setPanel(panel: "result", position: FloatingPanelPosition.half)
        
        var sel = filtteredCities[indexPath.row].title

        print(resultDelegate)
        resultDelegate?.cellSelected(dictAr.firstIndex(of: sel)!)
    }
}



class City: NSObject {
    var title:String
    
    init(title:String) {
        self.title = title
    }
}
