//
//  HourlyForecastRow.swift
//  Weather
//
//  Created by Артем Хлопцев on 28.04.2022.
//

import SwiftUI

struct HourlyForecastRow: View {
    let hourlyModel: Current
    let timeOffset: Int
    var body: some View {
        VStack(spacing: 10) {
            Group {
                Text("\(getHour())")
                    .fontWeight(.medium)
                +
                Text("\(getPartOfDay())")
                    .fontWeight(.medium)
                    .font(.footnote)
            }
            Image(systemName: hourlyModel.weather[0].getIconName().name)
                .foregroundStyle(hourlyModel.weather[0].getIconName().primaryColor, hourlyModel.weather[0].getIconName().secondaryColor, Color.theme.lightBlue)
                .font(.title3)
            Text("\(Int(round(hourlyModel.temp)))º")
        }
    }
    func getHour() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(hourlyModel.dt))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeOffset)
        dateFormatter.dateFormat = "h"
        return dateFormatter.string(from: date)
    }
    func getPartOfDay() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(hourlyModel.dt))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeOffset)
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: date)
    }
}

struct HourlyForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastRow(hourlyModel: dev.hourlyModel, timeOffset: 0)
    }
}
