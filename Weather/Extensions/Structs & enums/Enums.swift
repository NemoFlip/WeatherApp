//
//  Enums.swift
//  Weather
//
//  Created by Артем Хлопцев on 18.04.2022.
//

import SwiftUI


enum WeatherSquareInfo: String, Identifiable, CaseIterable {
    case UVIndex = "UV Index"
    case Sunrise
    case Wind
    case RainFall
    case FeelsLike = "Feels Like"
    case Humidity
    case Visibility
    case Pressure
    var id: String { self.rawValue }
    
    var name: String { self.rawValue }
    
    @ViewBuilder var view: some View {
        switch self {
        case .UVIndex:
            UVIndexView()
        case .Sunrise:
            SunriseView()
        case .Wind:
            WindView()
        case .Pressure:
            PressureView()
        case .Humidity:
            HumidityView()
        case .FeelsLike:
            FeelsLikeView()
        case .Visibility:
            VisibilityView()
        case .RainFall:
            RainFallView()
        }
    }
    var imageName: String {
        switch self {
        case .UVIndex:
            return "sun.max.fill"
        case .Sunrise:
            return "sunrise.fill"
        case .Wind:
            return "wind"
        case .Pressure:
            return "arrow.down.circle.fill"
        case .Humidity:
            return "humidity.fill"
        case .FeelsLike:
            return "humidity.fill"
        case .Visibility:
            return "eye.fill"
        case .RainFall:
            return "drop.fill"
        }
    }
}
