//
//  BusinessModel.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 28/12/2023.
//

import Foundation
import SwiftUI
import CoreLocation // for location

@Observable
// NSDObject and CLLocation and override innit is for location
class BusinessModel: NSObject, CLLocationManagerDelegate {
    var businesses = [Business]()
    var selectedBusiness: Business? // optional as nil to begin with
    
    var service = DataService()
    var locationManager = CLLocationManager()
    var currentUserLocation: CLLocationCoordinate2D?
    
    var locationAuthStatus: CLAuthorizationStatus = .notDetermined // if been given location authorisation
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
    }
    
    
    func getBusinesses(query: String?, options: String?, category: String?) {
        
        Task {
            businesses = await service.businessSearch(userLocation: currentUserLocation,
                                                      query: query,
                                                      options: options,
                                                      category: category)
        }
    }
    
    func getUserLocation() {
        
        // Check if we have permission
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil // flush user location
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // for these, type 'didFaileWithError' and the function will pop up
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locationAuthStatus = manager.authorizationStatus // when status changes, wi update this property
        // Detect if user allowed, then request location
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil // flush user location
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // this may fire multiple times, reduce accuracy of location to prevent this
        // If current user location is nill, get location
        if currentUserLocation == nil {
            currentUserLocation = locations.last?.coordinate // get most recent coordinate, optional bc may not exist
            // call business search
            getBusinesses(query: nil, options: nil, category: nil)
        }
        manager.stopUpdatingLocation() // stop updating bc it's draining on battery to continue
        
    }
}

