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
                Text(getDayOfWeek())
                    .subTextSquare()
                    .frame(maxWidth: 110, alignment: .leading)

                VStack {
                    Image(systemName: model.weather[0].getIconName().name)
                        .foregroundStyle(model.weather[0].getIconName().primaryColor, model.weather[0].getIconName().secondaryColor, Color.theme.lightBlue)
                        .font(.title3)
                    if let rainChance = model.pop, rainChance >= 0.1 {
                        Text("\(Int(rainChance * 100))%")
                            .foregroundColor(.theme.lightBlue)
                            .font(.system(size: 14))
                    }
                }
                Spacer(minLength: 0)
    
                HStack(spacing: 20) {
                    Text("\(Int(round(model.temp.min)))º")
                        .secondaryText()
                        .subTextSquare()
                
                    Text("\(Int(round(model.temp.max)))º")
                        .subTextSquare()
                }
            }
            if item != 7 {
                Divider()
            }
        }
    }
    func getDayOfWeek() -> String {
        let dateOfWeek = Date(timeIntervalSince1970: TimeInterval(model.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZoneOffset)
        if item == 0 {
            return "Today"
        }
        return dateFormatter.string(from: dateOfWeek)
    }
}

struct WeekForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        WeekForecastRow(item: 5, model: dev.dailyModel, timeZoneOffset: 0)
    }
}
