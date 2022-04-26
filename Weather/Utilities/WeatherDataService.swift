//
//  WeatherManager.swift
//  Weather
//
//  Created by Артем Хлопцев on 24.04.2022.
//

import Combine
import CoreLocation

class WeatherDataService {
    var cancellables: AnyCancellable?
    @Published var weatherModel: WeatherModel?

    func getWeatherData(coords: CLLocationCoordinate2D, lang: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(coords.latitude)&lon=\(coords.longitude)&exclude=minutely,alerts&appid=4de09c4dc94c40836ac29ac3adfe104c&units=metric&lang=\(lang)") else {
            return
        }
        print(url.absoluteString)
        cancellables = NetworkingManager.getData(url: url).decode(type: WeatherModel.self, decoder: JSONDecoder()).receive(on: DispatchQueue.main).sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedModel in
            self?.weatherModel = returnedModel
        })
    }
}
