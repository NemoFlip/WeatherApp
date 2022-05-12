//
//  WeatherManager.swift
//  Weather
//
//  Created by Артем Хлопцев on 24.04.2022.
//

import CoreLocation

class WeatherDataService {
    func getWeatherData(coords: CLLocationCoordinate2D, lang: String) async -> WeatherModel? {
        guard
            let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(coords.latitude)&lon=\(coords.longitude)&exclude=minutely,alerts&appid=4de09c4dc94c40836ac29ac3adfe104c&units=metric&lang=\(lang)"),
            let data = await NetworkingManager.getData(url: url) else {
                return nil
            }
        print(url.absoluteString)
        do {
            let model =  try JSONDecoder().decode(WeatherModel.self, from: data)
            return model
        } catch {
            print(error)
        }
        return nil
    }
}
