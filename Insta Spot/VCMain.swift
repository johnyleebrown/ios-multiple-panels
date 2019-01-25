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

class VCMain: UIViewController {
    

    @IBOutlet weak var mapView: MKMapView!
    
    //
    // MARK
    //
    
    var fpc: FloatingPanelController!
    var resultsVC: VCResultsPanel!
    
    var coords:[[Double]] = [[51.5099728,-0.1371599]]
    var deltas:[[Double]] = [[0.0525100023575723,0.05543697435880233]]
    var locationsNames:[String] = ["Piccadilly Circus"]
    var locationDescriptions:[String] = ["London, UK"]
    var locationsMarks:[Double] = [9.1]
    
    //
    // MARK
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up map view
        setupMapView()
        
        // set up results view
        setupResultsPanel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //  Add FloatingPanel to a view with animation.
        fpc.addPanel(toParent: self, animated: true)
    }
    
    //
    // MARK: - mapView
    //

    func setupMapView() {
        let center = CLLocationCoordinate2D(latitude: coords[0][0], longitude: coords[0][1])
        let span = MKCoordinateSpan(latitudeDelta: deltas[0][0],longitudeDelta: deltas[0][1])
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.region = region
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    //
    // MARK: - mapView
    //
    
    func setupResultsPanel() {
        // Do any additional setup after loading the view, typically from a nib.
        // Initialize FloatingPanelController
        fpc = FloatingPanelController()
        fpc.delegate = self
        
        // Initialize FloatingPanelController and add the view
        fpc.surfaceView.backgroundColor = .clear
        fpc.surfaceView.cornerRadius = 9.0
        fpc.surfaceView.shadowHidden = false
        
        resultsVC = storyboard?.instantiateViewController(withIdentifier: "ResultsPanel") as? VCResultsPanel
        
        // Set a content view controller
        fpc.set(contentViewController: resultsVC)
        fpc.track(scrollView: resultsVC.svLocationContent)
    }
}

extension VCMain:MKMapViewDelegate {
}

extension VCMain:FloatingPanelControllerDelegate {
}
