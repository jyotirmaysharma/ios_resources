//
//  MapController.swift
//  anomaly_mix
//
//  Created by Jyotirmay Sharma on 21/07/20.
//  Copyright © 2020 Jyotirmay Sharma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapKitController: MKMapView!
    
    @IBAction func toNavigationPressed(_ sender: UIButton) {
    }
    
    @IBAction func toIssPressed(_ sender: UIButton) {
    }
    
    var longitude: Double = 0;
    var latitude: Double = 0;
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    func configureEnvironment(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        //locationManager.requestLocation()
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
             let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapKitController.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            configureEnvironment()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
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
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapKitController.setRegion(region, animated: true)
        longitude = location.coordinate.longitude
        latitude = location.coordinate.latitude
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getLongitude() -> Double{
        locationManager.startUpdatingLocation()
        if longitude != 0{
            return longitude
        }
        else{
            return 0
        }
    }
    
    func getLatitude() -> Double{
        locationManager.startUpdatingLocation()
        if latitude != 0{
            return latitude
        }
        else{
            return 0
        }
    }
}
