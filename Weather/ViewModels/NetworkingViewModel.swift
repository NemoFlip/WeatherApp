//
//  NetworkingViewModel.swift
//  Weather
//
//  Created by Артем Хлопцев on 18.04.2022.
//
import CoreLocation
import Combine
import SwiftUI
class NetworkingViewModel: ObservableObject {
    @Published var weatherModel: WeatherModel?
    @Published var backColor: Color = .blue
    var cancellables = Set<AnyCancellable>()
    let dataService = WeatherDataService()
    // If needed i will initialize lang and coords
    init(coords: CLLocationCoordinate2D, lang: String) {
        addSubscribers(coords: coords, lang: lang)
    }
    func addSubscribers(coords: CLLocationCoordinate2D, lang: String) {
        dataService.getWeatherData(coords: coords, lang: lang)
        self.dataService.$weatherModel.sink { [weak self] returnedModel in
                self?.weatherModel = returnedModel
            self?.backColor = returnedModel?.current.weather[0].getBackColor() ?? .gray
        }.store(in: &self.cancellables)
    }
}
