//
//  WeatherModel.swift
//  Weather
//
//  Created by Артем Хлопцев on 24.04.2022.
//

import Foundation
import SwiftUI

struct WeatherModel: Codable {
    let lat, lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: Current
    let hourly: [Current]
    let daily: [Daily]
}

// MARK: - Current
struct Current: Codable, Hashable {
    static func == (lhs: Current, rhs: Current) -> Bool {
        lhs.dt == rhs.dt
    }
    
    let dt: Int
    let sunrise, sunset: Int?
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [Weather]
    let rain: Rain?
    let pop: Double?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, rain, pop
    }
}

// MARK: - Rain
struct Rain: Codable, Hashable {
    let the1H: Double
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Weather
struct Weather: Codable, Hashable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: Icon
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    func getIconName() -> (name: String, primaryColor: Color, secondaryColor: Color) {
        switch icon {
        case .the01D:
            return ("sun.max.fill", .yellow, .yellow)
        case .the02D:
            return ("cloud.sun.fill", .white, .yellow)
        case .the03D, .the04D:
            return ("cloud.fill", .white, .white)
        case .the09D:
            return ("cloud.rain.fill", .white, .white)
        case .the10D:
            return ("cloud.sun.rain.fill", .white, .yellow)
        case .the11D:
            return ("cloud.bolt.fill", .white, .white)
        case .the13D, .the13N:
            return ("snowflake", .white, .white)
        case .the50D, .the50N:
            return ("cloud.fog.fill", .white, .white)
            
        case .the01N:
            return ("moon.stars.fill", .white, .white)
        case .the02N, .the03N, .the04N:
            return ("cloud.moon.fill", .white, .white)
        case .the09N, .the10N:
            return ("cloud.moon.rain.fill", .white, .white)
        case .the11N:
            return ("cloud.moon.bolt.fill", .white, .white)
        }
    }
    func getBackImageName() -> String {
        switch icon {
        case .the01D, .the02D:
            return "sun"
        case .the01N:
            return "nightClear"
        case .the02N, .the50N, .the11N:
            return "fewCloudsNight"
        case .the03D, .the03N, .the50D:
            return "clouds"
        case .the04D, .the04N, .the09D, .the09N, .the10D, .the10N, .the11D:
            return "brokenClouds"
        case .the13D, .the13N:
            return "snow"
        }
    }
}

enum Icon: String, Codable {
    case the01D = "01d"
    case the01N = "01n"
    
    case the02D = "02d"
    case the02N = "02n"
    
    case the03D = "03d"
    case the03N = "03n"
    
    case the04D = "04d"
    case the04N = "04n"
    
    case the09D = "09d"
    case the09N = "09n"
    
    case the10D = "10d"
    case the10N = "10n"
    
    case the11D = "11d"
    case the11N = "11n"
    
    case the13D = "13d"
    case the13N = "13n"
    
    case the50D = "50d"
    case the50N = "50n"
}

// MARK: - Daily
struct Daily: Codable, Hashable {
    static func == (lhs: Daily, rhs: Daily) -> Bool {
        lhs.dt == rhs.dt
    }
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
    let temp: Temp
    let weather: [Weather]
    let pop: Double
    let rain: Double?
    let uvi: Double
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case temp
        case rain
        case weather
        case uvi
        case pop
    }
}

// MARK: - Temp
struct Temp: Codable, Hashable {
    let day, min, max, night: Double
    let eve, morn: Double
}


