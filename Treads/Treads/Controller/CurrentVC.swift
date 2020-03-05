//
//  CurrentVC.swift
//  Treads
//
//  Created by Lucas Inocencio on 13/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class CurrentVC: LocationVC {
    
    // Outlets
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbPace: UILabel!
    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var ivSwipeBG: UIImageView!
    @IBOutlet weak var ivSliderImage: UIImageView!
    @IBOutlet weak var btPause: UIButton!
    
    // Variables
    fileprivate var startLocation: CLLocation!
    fileprivate var lastLocation: CLLocation!
    fileprivate var runDistance = 0.0
    fileprivate var pace = 0
    fileprivate var timer = Timer()
    fileprivate var coordinateLocations = List<Location>()
    fileprivate var counter = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwipped(sender:)))
        ivSliderImage.addGestureRecognizer(swipeGesture)
        ivSliderImage.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
    }
    
    func startRun() {
        manager?.startUpdatingLocation()
        startTimer()
        btPause.setImage(UIImage(named: "pauseButton"), for: .normal)
    }
    
    func endRun() {
        manager?.stopUpdatingLocation()
        Run.addRunToRealm(pace: pace, distance: runDistance, duration: counter, locations: coordinateLocations)
    }
    
    func pauseRun() {
        startLocation = nil
        lastLocation = nil
        timer.invalidate()
        manager?.stopUpdatingLocation()
        btPause.setImage(UIImage(named: "resumeButton"), for: .normal)
    }
    
    func startTimer() {
        lbDuration.text = counter.formatTimerDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting() {
        counter += 1
        lbDuration.text = counter.formatTimerDurationToString()
    }
    
    func calculatePace(time seconds: Int, miles: Double) -> String {
        pace = Int(Double(seconds) / miles)
        return pace.formatTimerDurationToString()
    }
    
    @objc func endRunSwipped(sender: UIPanGestureRecognizer) {
        let minAdjust: CGFloat = 80
        let maxAdjust: CGFloat = 128
        
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
                
                if sliderView.center.x >= (ivSwipeBG.center.x - minAdjust) && sliderView.center.x <= (ivSwipeBG.center.x + maxAdjust) {
                    sliderView.center.x = sliderView.center.x + translation.x
                } else if sliderView.center.x >= (ivSwipeBG.center.x + maxAdjust) {
                    sliderView.center.x = ivSwipeBG.center.x + maxAdjust
                    endRun()
                    dismiss(animated: true, completion: nil)
                } else {
                    sliderView.center.x = ivSwipeBG.center.x - minAdjust
                }
                
                sender.setTranslation(CGPoint.zero, in: self.view)
            } else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1) {
                    sliderView.center.x = self.ivSwipeBG.center.x - minAdjust
                }
            }
        }
    }
    
    @IBAction func pauseTouched(_ sender: Any) {
        if timer.isValid {
            pauseRun()
        } else {
            startRun()
        }
    }
    
}

extension CurrentVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
            let newLocation = Location(latitude: Double(lastLocation.coordinate.latitude), longitude: Double(lastLocation.coordinate.longitude))
            coordinateLocations.insert(newLocation, at: 0)
            lbDistance.text = "\(runDistance.metersToMiles(places: 2))"
            if counter > 0 && runDistance > 0 {
                lbPace.text = calculatePace(time: counter, miles: runDistance.metersToMiles(places: 2))
            }
        }
        lastLocation = locations.last
    }
}

