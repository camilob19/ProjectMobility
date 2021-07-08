//
//  MapCountryViewController.swift
//  ProjectMobility
//
//  Created by Camilo Betancourt on 17/06/21.
//

import UIKit
import MapKit
import CoreLocation

class MapCountryViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var position: CLLocationCoordinate2D?
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let position = position else { return }
        annotation.coordinate = position
        mapView.addAnnotation(annotation)
        mapView.setCenter(position, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
