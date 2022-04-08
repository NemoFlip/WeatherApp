//
//  SearchBar.swift
//  Weather
//
//  Created by Артем Хлопцев on 06.04.2022.
//

import Foundation
import SwiftUI
import MapKit

struct SearchBar: UIViewRepresentable {
    @Binding var result: [SearchModel]
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.autocorrectionType = .no
        searchBar.placeholder = "City name..."
        searchBar.autocapitalizationType = .none
        searchBar.delegate = context.coordinator
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar, context: Context) { }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        let parent: SearchBar
        init(parent: SearchBar) {
            self.parent = parent
        }
        private var pendingRequestWorkItem: DispatchWorkItem?
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            let req = MKLocalSearch.Request()
            req.region = MKCoordinateRegion(.world)
            req.naturalLanguageQuery = searchText.isEmpty ? "Moscow" : searchText
            req.resultTypes = .address
            let mkSearch = MKLocalSearch(request: req)
            pendingRequestWorkItem?.cancel()
            
            let requestWorkItem = DispatchWorkItem { [weak self] in
                mkSearch.start { data, error in
                    guard let data = data, error == nil else {
                        print("Error downloading cities: \(String(describing: error))")
                        mkSearch.cancel()
                        return
                    }
                    self?.parent.result.removeAll()
                    self?.parent.result = data.mapItems.map { mapItem in
                        let tempData = SearchModel(cityName: mapItem.name ?? "", coordinates: mapItem.placemark.coordinate)
                        return tempData
                    }.filter({ $0.cityName != "" })
                }
            }
            pendingRequestWorkItem = requestWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500),
                                          execute: requestWorkItem)
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
