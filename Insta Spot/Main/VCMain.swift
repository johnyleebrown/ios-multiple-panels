//
//  VCMain.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/25/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit
import MapKit
import FloatingPanel

protocol VCMainDelegate {
    func getPanelPosition(name:String) -> FloatingPanelPosition?
    func updateMap(index:String)
    func setPanel(panel: String, position:FloatingPanelPosition)
}

class VCMain: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var fpcResults: FloatingPanelController!
    
    var fpcSearch: FloatingPanelController!
    
    var resultsVC: VCResultsPanel!
    
    var searchVC: VCSearchPanel!
    
    var coords:[[Double]] = [[51.5099728,
                              -0.1371599]]
    
    var locationsNames:[String] = ["Piccadilly Circus"]
    
    var locationDescriptions:[String] = ["London, UK"]
    
    var locationsMarks:[Double] = [9.1]
    
    let annotation = MKPointAnnotation()
    
    var deltas:[[Double]] = [[0.0525100023575723,
                              0.05543697435880233],
                             [0.3025100023575723,
                              0.30543697435880233]]
    
    let dict: Dictionary = ["rome":[41.902782, 12.496366],
                            "cairo":[30.045322, 31.239624],
                            "moscow":[55.751244, 37.618423],
                            "new delhi":[28.644800, 77.216721]]
    //
    //
    // MARK: - on start
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up map view
        setupMapView()
        
        
        // set up results view
        setupResultsPanel()
        
        // set up search view
        setupSearchPanel()
        
    }
    
    func printAllSubviews(of view: UIView, from layer: Int) {
        for _ in 0..<layer {
            print(" ", separator: "", terminator: "")
        }
        print("\(view): ")
        let subView = view.subviews
        if subView.count != 0 {
            subView.forEach({ (view) in
                printAllSubviews(of: view, from: layer + 1)
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
        // Add FloatingPanel Results to a view with animation.
        fpcResults.addPanel(toParent: self, animated: true)
        
        // Add FloatingPanel Search to a view with animation.
        fpcSearch.addPanel(toParent: self, animated: true)
        fpcSearch.move(to: .full, animated: true)
        
//        printAllSubviews(of: view, from: 0)
    }
    
    //
    //
    // MARK: - mapView
    //

    func setupMapView() {
        let center = CLLocationCoordinate2D(latitude: coords[0][0], longitude: coords[0][1])
        let span = MKCoordinateSpan(latitudeDelta: deltas[0][0],longitudeDelta: deltas[0][1])
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.region = region
        mapView.delegate = self
    }
    
    //
    //
    // MARK: - ResultsPanel
    //
    
    func setupResultsPanel() {
        // Do any additional setup after loading the view, typically from a nib.
        // Initialize FloatingPanelController
        fpcResults = FloatingPanelController()
        fpcResults.delegate = self
        
        // Initialize FloatingPanelController and add the view
        fpcResults.surfaceView.backgroundColor = .clear
        fpcResults.surfaceView.cornerRadius = 9.0
        fpcResults.surfaceView.shadowHidden = false
        
        resultsVC = storyboard?.instantiateViewController(withIdentifier: "ResultsPanel") as? VCResultsPanel
        resultsVC.delegate = self
        
        // Set a content view controller
        fpcResults.set(contentViewController: resultsVC)
        fpcResults.track(scrollView: resultsVC.svLocationContent)
    }
    
    //
    //
    // MARK: - SearchPanel
    //
    
    func setupSearchPanel() {
        // Do any additional setup after loading the view, typically from a nib.
        // Initialize FloatingPanelController
        fpcSearch = FloatingPanelController()
        fpcSearch.delegate = self
        
        // Initialize FloatingPanelController and add the view
        fpcSearch.surfaceView.backgroundColor = .clear
        fpcSearch.surfaceView.cornerRadius = 20.0
        
        searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchPanel") as? VCSearchPanel
        searchVC.mainDelegate = self
        searchVC.resultDelegate = resultsVC
        
        // Set a content view controller
        fpcSearch.set(contentViewController: searchVC)
        fpcSearch.track(scrollView: searchVC.cvSearchResults)
    }
}

//
//
//
//
//

extension VCMain:MKMapViewDelegate {
}

extension VCMain:FloatingPanelControllerDelegate {
}

extension VCMain:VCMainDelegate {
    func getPanelPosition(name: String) -> FloatingPanelPosition? {
        switch name {
        case "search":
            return fpcSearch.position
        case "result":
            return fpcResults.position
        default:
            return nil
        }
    }
    
    
//    func getPositionFromStr(position: String) -> FloatingPanelPosition {
//        switch position {
//        case "hidden":
//            return .hidden
//        case "full":
//            return .full
//        case "half":
//            return .half
//        case "tip":
//            return .tip
//        default:
//            return .tip
//        }
//    }
    
    func setPanel(panel: String, position: FloatingPanelPosition) {
        switch panel {
            case "result":
                fpcResults.move(to: position, animated: true)
            case "search":
                fpcSearch.move(to: position, animated: true)
            default:
                return
        }
    }
    
    func updateMap(index:String) {
        let loc:[Double] = dict[index]!
        let center = CLLocationCoordinate2D(latitude: loc[0], longitude: loc[1])
        let span = MKCoordinateSpan(latitudeDelta: deltas[1][0], longitudeDelta: deltas[1][1])
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: loc[0], longitude: loc[1])
        mapView.addAnnotation(annotation)
        
        mapView.updateFocusIfNeeded()
    }
    
}

