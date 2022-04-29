//
//  PreviewProvider.swift
//  Weather
//
//  Created by Артем Хлопцев on 08.04.2022.
//

import Foundation
import SwiftUI
extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}
extension View {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}
class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    let mapVM = MapViewModel()
    let dailyModel = Daily(dt: 0, sunrise: 0, sunset: 0, moonrise: 0, moonset: 0, temp: Temp(day: 0, min: 0, max: 0, night: 0, eve: 0, morn: 0), weather: [], pop: 0, rain: 0, uvi: 0)
    let hourlyModel = Current(dt: 0, sunrise: 0, sunset: 0, temp: 0, feelsLike: 0, pressure: 0, humidity: 0, dewPoint: 0, uvi: 0, clouds: 0, visibility: 0, windSpeed: 0, windDeg: 0, windGust: 0, weather: [Weather(id: 800, main: "Clear", weatherDescription: "clear sky", icon: Icon(rawValue: "01d")!)], rain: nil, pop: 0)
}
