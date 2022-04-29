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
                Text("\(checkNowTime() ? "Now" : getDateFromUNIX(timeOffset: timeOffset, currentDate: hourlyModel.dt ,dateFormat: "h"))")
                    .fontWeight(.medium)
                +
                Text("\(checkNowTime() ? "" : getDateFromUNIX(timeOffset: timeOffset, currentDate: hourlyModel.dt ,dateFormat: "a"))")
                    .fontWeight(.medium)
                    .font(.footnote)
            }
            Image(systemName: hourlyModel.weather[0].getIconName().name)
                .foregroundStyle(hourlyModel.weather[0].getIconName().primaryColor, hourlyModel.weather[0].getIconName().secondaryColor, Color.theme.lightBlue)
                .font(.title3)
            Text("\(Int(round(hourlyModel.temp)))º")
        }
    }
    func checkNowTime() -> Bool {
        getDateFromUNIX(timeOffset: timeOffset, currentDate: hourlyModel.dt ,dateFormat: "h") == getDateFromUNIX(timeOffset: timeOffset, currentDate: Int(Date().timeIntervalSince1970), dateFormat: "h")
    }
}

struct HourlyForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastRow(hourlyModel: dev.hourlyModel, timeOffset: 0)
    }
}
