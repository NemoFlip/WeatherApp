//
//  WeekForecastRow.swift
//  Weather
//
//  Created by Артем Хлопцев on 14.04.2022.
//

import SwiftUI

struct WeekForecastRow: View {
    var item: Int
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 35) {
                Text("Сегодня")
                    .font(.system(size: 18, weight: .medium, design: .default))
                Spacer()
                Image(systemName: "sun.max.fill")
                Spacer()
                Text("2º")
                    .secondaryText()
                    .font(.system(size: 18, weight: .medium, design: .default))
                Text("19º")
                    .font(.system(size: 18, weight: .medium, design: .default))
            }
            if item != 10 {
                Divider()
            }
        }
    }
}

struct WeekForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        WeekForecastRow(item: 5)
    }
}
