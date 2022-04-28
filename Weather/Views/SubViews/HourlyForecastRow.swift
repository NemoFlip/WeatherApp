//
//  HourlyForecastRow.swift
//  Weather
//
//  Created by Артем Хлопцев on 28.04.2022.
//

import SwiftUI

struct HourlyForecastRow: View {
    let hourlyModel: Current
    var body: some View {
        VStack(spacing: 10) {
            Text("Now")
            Image(systemName: "cloud.fill")
            Text("11º")
        }
    }
}

struct HourlyForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastRow(hourlyModel: dev.hourlyModel)
    }
}
