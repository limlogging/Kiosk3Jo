//
//  MapViewController.swift
//  Kiosk
//
//  Created by Dongik Song on 4/5/24.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var branchLabel: UILabel!
    
    let coordinates = CLLocationCoordinate2D(
        latitude: 37.503702192, longitude: 127.025313873406
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
        
        addBranch()
        branchLabel.numberOfLines = 0
        branchLabel.text = "Fine Apple Store 강남점 \n주소: 서울특별시 강남구 강남대로 🍍🍍🍍"
    }
    
    func addBranch () {
        let pin = MKPointAnnotation()
        pin.title = "🍍 Fine Apple Store 강남점"
        pin.subtitle = "본점"
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
    }
    
}

