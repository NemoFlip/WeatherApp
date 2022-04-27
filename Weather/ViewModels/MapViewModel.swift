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
    @Published var trackLocations: [SearchModel] = [] // when searching location
    @Published var noLocation = false
    @AppStorage(UserLocationKeys.userLocations) var userLocations: [SearchModel] = [] // all user locatons
    func getLanguage() -> String {
        let lang = Locale.preferredLanguages[0].components(separatedBy: "-").first ?? "en"
        return lang
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(userLocations)
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
        } else if manager.authorizationStatus == .denied && self.userLocations.isEmpty {
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
            let userAddress = placemarks.first?.locality ?? ""
            if !self.userLocations.contains(where: { $0.coordinates == self.userLocation.coordinate }) {
                self.userLocations.append(SearchModel(cityName: userAddress, coordinates: self.userLocation.coordinate))
            }
        }
    }
}
