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
//        VStack(spacing: (hourlyModel.pop ?? 0) >= 0.1 ? 2 : 10) {
        VStack {
            Group {
                Text("\(checkNowTime() ? "Now" : getDateFromUNIX(timeOffset: timeOffset, currentDate: hourlyModel.dt ,dateFormat: "h"))")
                    .fontWeight(.medium)
                +
                Text("\(checkNowTime() ? "" : getDateFromUNIX(timeOffset: timeOffset, currentDate: hourlyModel.dt ,dateFormat: "a"))")
                    .fontWeight(.medium)
                    .font(.footnote)
            }.frame(maxHeight: .infinity, alignment: .top)
            VStack(spacing: 0) {
                Image(systemName: hourlyModel.weather[0].getIconName().name)
                    .foregroundStyle(hourlyModel.weather[0].getIconName().primaryColor, hourlyModel.weather[0].getIconName().secondaryColor, Color.theme.lightBlue)
                    .font((hourlyModel.pop ?? 0) >= 0.1 ? .title3 : .title2)
                if let rainChance = hourlyModel.pop, rainChance >= 0.1 {
                    Text("\(Int(rainChance * 100))%")
                        .foregroundColor(.theme.lightBlue)
                        .font(.system(size: 14))
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
            Text("\(Int(round(hourlyModel.temp)))º")
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    func checkNowTime() -> Bool {
        getDateFromUNIX(timeOffset: timeOffset, currentDate: hourlyModel.dt ,dateFormat: "d, h") == getDateFromUNIX(timeOffset: timeOffset, currentDate: Int(Date().timeIntervalSince1970), dateFormat: "d, h")
    }
}

struct HourlyForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastRow(hourlyModel: dev.hourlyModel, timeOffset: 0)
    }
}
