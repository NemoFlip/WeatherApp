//
//  NetworkingViewModel.swift
//  Weather
//
//  Created by Артем Хлопцев on 18.04.2022.
//

import Foundation
import CoreLocation
import Combine
class NetworkingViewModel: ObservableObject {
    @Published var weatherModel: WeatherModel?
    var cancellables = Set<AnyCancellable>()
    let dataService = WeatherDataService()
    // If needed i will initialize lang and coords
    init(coords: CLLocationCoordinate2D, lang: String) {
        addSubscribers(coords: coords, lang: lang)
        print("Subscribers added!")
    }
    func addSubscribers(coords: CLLocationCoordinate2D, lang: String) {
        dataService.getWeatherData(coords: coords, lang: lang)
        self.dataService.$weatherModel.sink { [weak self] returnedModel in
            print("SUCCESS")
            self?.weatherModel = returnedModel
        }.store(in: &self.cancellables)
    }
}
