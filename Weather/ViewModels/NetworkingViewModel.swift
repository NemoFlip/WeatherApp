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
    @Published var backImageName: String = "clouds"
    var cancellables = Set<AnyCancellable>()
    let dataService = WeatherDataService()
    init(coords: CLLocationCoordinate2D, lang: String) {
        Task(priority: .high) {
            await addSubscribers(coords: coords, lang: lang)
        }
    }
    private func addSubscribers(coords: CLLocationCoordinate2D, lang: String) async {
        let tempModel =  await dataService.getWeatherData(coords: coords, lang: lang)
        await MainActor.run {
            self.weatherModel = tempModel
            self.backImageName = weatherModel?.current.weather[0].getBackImageName() ?? "clouds"
        }
        
//        dataService.getWeatherData(coords: coords, lang: lang)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.dataService.$weatherModel.sink { [weak self] returnedModel in
//                    self?.weatherModel = returnedModel
//                    self?.backImageName = returnedModel?.current.weather[0].getBackImageName() ?? "clouds"
//            }.store(in: &self.cancellables)
//        }
        
    }
}
