//
//  ViewController.swift
//  anomaly_mix
//
//  Created by Jyotirmay Sharma on 21/07/20.
//  Copyright © 2020 Jyotirmay Sharma. All rights reserved.
//

import UIKit
import CoreLocation

class NavigationUtilityController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
     
    var mapViewController = MapViewController()
    var lon: Double = 0;
    var lat: Double = 0;
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            
            locationManager.requestLocation()
            break
        case .authorizedAlways:
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func getLocationPressed(_ sender: UIButton) {
        latitudeLabel.text = "Lat: \(lat)"
        longitudeLabel.text = "Lon: \(lon)"
    }
}
