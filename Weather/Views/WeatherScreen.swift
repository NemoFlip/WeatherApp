//
//  WeatherScreen.swift
//  Weather
//
//  Created by Артем Хлопцев on 13.04.2022.
//

import SwiftUI

struct WeatherScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            headerSection
            
            hourForecastSection
            
            weekForecastSection
            
        }.padding(.horizontal, 10).foregroundColor(.white).background(Color.gray.ignoresSafeArea())
    }
}

struct WeatherScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen()
    }
}

extension WeatherScreen {
    private var headerSection: some View {
        VStack(spacing: 2) {
            
            Text("Альметьевск")
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
        WeatherRectangleView {
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
                
            }.padding(.horizontal).padding(.bottom)
        } label: {
            VStack(alignment: .leading) {
                Text("Ожидается ясная погода около 19:00")
                    .font(.subheadline)
                Divider()
            }.padding()
        }
    }
    private var weekForecastSection: some View {
        WeatherRectangleView {
            VStack(alignment: .leading) {
                ForEach(0..<11) { item in
                    WeekForecastRow(item: item)
                }
            }.padding(.horizontal).padding(.bottom)
        } label: {
            WeatherScreenHeader(imageSystemName: "calendar", headerText: "Прогноз на 10 дн")
        }
    }
}
