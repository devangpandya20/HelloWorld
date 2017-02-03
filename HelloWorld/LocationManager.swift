//
//  LocationManager.swift
//  HelloWorld
//
//  Created by Devang Pandya on 03/02/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

import Foundation
import CoreLocation
protocol LocationServiceDelegate{
    func tracingCity(cityName : String)
    func errorLocatingCity(error : Error)
}

class LocationManager : NSObject,CLLocationManagerDelegate{
    static let sharedInstance = LocationManager()
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    
    override private init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers // The accuracy of the location data
        locationManager.delegate = self
        print("LocationManager Initialized")
    }
    
    func startUpdatingLocation(){
        print ("Start Updating Location")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation(){
        print("Stop Updating Location")
        self.locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.currentLocation = location
        getCityFromLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocationDidFailWithError(error: error)
    }
    
    
    
    private func getCityFromLocation(){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(self.currentLocation!) { (placemarks, error) in
            guard let placeMark : CLPlacemark = placemarks?.last else {
                return
            }
            print(placeMark.locality)
            print(placeMark.administrativeArea)
        }
    }
    
    private func updateLocation(currentLocation : CLLocation){
        guard let delegate = self.delegate else{
            return
        }
        delegate.tracingCity(cityName: "City")
    }
    private func updateLocationDidFailWithError(error: Error) {
        
        guard let delegate = self.delegate else {
            return
        }
        delegate.errorLocatingCity(error: error)
    }
}
