//
//  WeatherScreen.swift
//  Weather
//
//  Created by Артем Хлопцев on 13.04.2022.
//

import SwiftUI

struct WeatherScreen: View {
    @State var heightRect: CGFloat = .zero
    @Binding var name: String
    var body: some View {
        ScrollView(showsIndicators: false) {
            headerSection

            hourForecastSection

            weekForecastSection
            
            gridOfWeatherInfoSquares
            
        }
        .padding(.horizontal, 10)
        .foregroundColor(.white)
        .background(Color.blue.ignoresSafeArea())
    }
}
struct WeatherScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen(name: .constant(""))
    }
}

extension WeatherScreen {
    private var headerSection: some View {
        VStack(spacing: 2) {
            Text(name.localizedCapitalized)
                .font(.system(size: 28, weight: .regular, design: .default))
            Text("12º")
                .font(.system(size: 80, weight: .thin, design: .default))
            Group {
                Text("Переменная облачность")
                Text("Макс.: 15º, мин.: 2º")
                    .padding(.bottom, 30)
            }.font(.system(size: 15, weight: .medium, design: .default))
            
        }.padding(.top, 50)
    }
    private var hourForecastSection: some View {
        WeatherRectangleView(isSquare: false) {
            ScrollView(.horizontal ,showsIndicators: false) {
                HStack {
                    ForEach(0..<10) {item in
                        VStack(spacing: 8) {
                            Text("Now")
                            Image(systemName: "cloud.fill")
                            Text("11º")
                        }
                    }
                }
            }
            
        } label: {
            VStack(alignment: .leading) {
                Text("Ожидается ясная погода около 19:00")
                    .font(.subheadline)
                Divider()
            }
        }
    }
    private var weekForecastSection: some View {
        WeatherRectangleView(isSquare: false) {
            VStack(alignment: .leading) {
                ForEach(0..<11) { item in
                    WeekForecastRow(item: item)
                }
            }
        } label: {
            WeatherScreenHeader(showDivider: true, imageSystemName: "calendar", headerText: "Прогноз на 10 дн")
        }
    }
    private var weatherInfoSquarePreference: some View {
        WeatherRectangleView(isSquare: true) {
            GeometryReader { geo in
                SunriseView()
                .preference(key: CustomHeightPreferenceKey.self, value: geo.size.width - 40) // 40 is header height
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }.frame(height: heightRect)
        } label: {
            WeatherScreenHeader(showDivider: false, imageSystemName: "sun.max", headerText: "УФ-Индекс")
        }
        .onPreferenceChange(CustomHeightPreferenceKey.self) { self.heightRect = $0 }
    }
    private var weatherInfoSquare: some View {
        WeatherRectangleView(isSquare: true) {
            WindView()
            .frame(maxWidth: .infinity, maxHeight: .infinity) // .leading for all but WindView
            .frame(height: heightRect)
            
        } label: {
            WeatherScreenHeader(showDivider: false, imageSystemName: "sun.max", headerText: "УФ-Индекс")
        }
    }
    private var gridOfWeatherInfoSquares: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 8),
            GridItem(.flexible())
        ], alignment: .center, spacing: 8) {
            ForEach(0..<8) { item in
                if item == 0 {
                    weatherInfoSquarePreference
                } else {
                    weatherInfoSquare
                }
            }
        }
        .padding(.bottom, 50)
    }
}
