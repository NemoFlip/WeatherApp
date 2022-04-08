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
    @Published var trackLocations: Set<SearchModel> = []
    @Published var noLocation = false
    @AppStorage("userAddress") var userAddress = ""
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus != .denied {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse:
                print("Authorized")
                self.noLocation = false
                manager.requestLocation()
            default:
                print("Unknown")
                self.noLocation = false
                manager.requestWhenInUseAuthorization()
            }
        } else if manager.authorizationStatus == .denied && self.userAddress == "" {
            print("Denied")
            self.noLocation = true
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
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
            self.userAddress = placemarks.first?.locality ?? ""
            self.trackLocations.insert(SearchModel(cityName: self.userAddress, coordinates: self.userLocation.coordinate))
        }
    }
}
