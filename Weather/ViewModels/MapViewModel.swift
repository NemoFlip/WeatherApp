//
//  MapViewModel.swift
//  Weather
//
//  Created by Артем Хлопцев on 05.04.2022.
//

import SwiftUI
import MapKit
import CoreLocation
class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(MKMapRect(x: 0, y: 0, width: 0, height: 0))
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("Denied")
            self.noLocation = true
        default:
            print("Unknown")
            self.noLocation = false
            manager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        self.region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000000, longitudinalMeters: 100000)
        self.extractLocation()
    }
    private func extractLocation() {
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { placemarks, error in
            guard let placemarks = placemarks,
                  error == nil else {
                      print("Error extrancing location: \(String(describing: error))")
                      return
                  }
             
            print(placemarks)
            let address = placemarks.first?.locality ?? ""
            self.userAddress = address
        }
    }
}
