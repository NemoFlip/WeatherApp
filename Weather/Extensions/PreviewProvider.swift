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
class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    let mapVM = MapViewModel()
    let dailyModel = Daily(dt: 0, sunrise: 0, sunset: 0, moonrise: 0, moonset: 0, temp: Temp(day: 0, min: 0, max: 0, night: 0, eve: 0, morn: 0), weather: [], rain: 0, uvi: 0)
}
