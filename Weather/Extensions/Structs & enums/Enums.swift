//
//  Enums.swift
//  Weather
//
//  Created by Артем Хлопцев on 18.04.2022.
//

import SwiftUI


enum WeatherSquareInfo: String, Identifiable {
    case UVIndex = "UV Index"
    case Sunrise
    case Wind
    case Pressure
    case Humidity
    case FeelsLike = "Feels Like"
    case Visibility
    
    var id: String { self.rawValue }
    
    var name: String { self.rawValue }
    
//    @ViewBuilder var view: some View {
//        switch self {
//        case .UVIndex:
//            <#code#>
//        case .Sunrise:
//            <#code#>
//        case .Wind:
//            <#code#>
//        case .Pressure:
//            <#code#>
//        case .Humidity:
//            <#code#>
//        case .FeelsLike:
//            <#code#>
//        case .Visibility:
//            <#code#>
//        }
//    }
}
