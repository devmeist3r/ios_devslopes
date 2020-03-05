//
//  BeginRunV.swift
//  Treads
//
//  Created by Lucas Inocencio on 12/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class BeginRunVC: LocationVC {

    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btClose: UIButton!
    @IBOutlet weak var lbPace: UILabel!
    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var vLastRunBG: UIView!
    @IBOutlet weak var svLastRun: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
//        print("here are my runs: \(Run.getAllRuns())")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingHeading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         setupMapView() 
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupMapView() {
        if let overlay = addLastRunTopMap() {
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(overlay)
            svLastRun.isHidden = false
            vLastRunBG.isHidden = false
            btClose.isHidden = false
        } else {
            svLastRun.isHidden = true
            vLastRunBG.isHidden = true
            btClose.isHidden = true
            centerMapOnUserLocation()
        }
    }
    
    func addLastRunTopMap() -> MKPolyline? {
        
        guard let lastRun = Run.getAllRuns()?.first else { return nil }
        lbPace.text = lastRun.pace.formatTimerDurationToString()
        lbDistance.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        lbDuration.text = lastRun.duration.formatTimerDurationToString()
        
        var coordinate = [CLLocationCoordinate2D]()
        for location in lastRun.locations {
            coordinate.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        
        mapView.userTrackingMode = .none
        guard let locations = Run.getRun(byId: lastRun.id)?.locations else { return MKPolyline() }
        mapView.setRegion(centerMapOnUserLocation(locations: locations), animated: true)
        
        return MKPolyline(coordinates: coordinate, count: locations.count)
    }
    
    func centerMapOnUserLocation() {
        mapView.userTrackingMode = .follow
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func centerMapOnUserLocation(locations: List<Location>) -> MKCoordinateRegion {
        guard let initialLoc = locations.first else { return MKCoordinateRegion() }
        var minLat = initialLoc.latitude
        var minLng = initialLoc.latitude
        var maxLat = minLat
        var maxLng = minLng
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLng = min(minLng, location.longitude)
            maxLat = max(maxLat, location.latitude)
            maxLng = max(maxLat, location.longitude)
        }
        
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2, longitude: (minLng + maxLng)/2), span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat)*1.4, longitudeDelta: (maxLng)*1.4))
    }
    
    @IBAction func centerTouched(_ sender: Any) {
        centerMapOnUserLocation()
    }
    
    @IBAction func closeButtonTouched(_ sender: Any) {
        svLastRun.isHidden = true
        vLastRunBG.isHidden = true
        btClose.isHidden = true
        centerMapOnUserLocation()
    }
    
}

extension BeginRunVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        renderer.lineWidth = 4
        return renderer
    }
    
}
