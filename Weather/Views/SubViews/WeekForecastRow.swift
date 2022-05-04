//
//  WeekForecastRow.swift
//  Weather
//
//  Created by Артем Хлопцев on 14.04.2022.
//

import SwiftUI

struct WeekForecastRow: View {
    var item: Int
    var model: Daily
    var timeZoneOffset: Int
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 35) {
                Text(item == 0 ? "Today" : getDateFromUNIX(timeOffset: timeZoneOffset, currentDate: model.dt, dateFormat: "EEEE"))
                    .subTextSquare()
                    .frame(width: 110, alignment: .leading)

                VStack(alignment: .leading, spacing: 0) {
                    Image(systemName: model.weather[0].getIconName().name)
                        .foregroundStyle(model.weather[0].getIconName().primaryColor, model.weather[0].getIconName().secondaryColor, Color.theme.lightBlue)
                        .font(.title3)
                    if let rainChance = model.pop, rainChance >= 0.1 {
                        Text("\(Int(rainChance * 100))%")
                            .foregroundColor(.theme.lightBlue)
                            .font(.system(size: 12))
                    }
                }.frame(maxWidth: 50, maxHeight: 50)
                Spacer()
                HStack {
                    Text("\(Int(round(model.temp.min)))º")
                        .secondaryText()
                        .subTextSquare()
                    Spacer()
                    Text("\(Int(round(model.temp.max)))º")
                        .subTextSquare()
                }
            }
            if item != 7 {
                Divider()
            }
        }
    }
}

struct WeekForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        WeekForecastRow(item: 5, model: dev.dailyModel, timeZoneOffset: 0)
    }
}
