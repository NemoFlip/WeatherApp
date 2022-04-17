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
            
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: nil)
            ], alignment: .center, spacing: 8) {
                ForEach(0..<10) { item in
                    if item == 0 {
                        WeatherRectangleView {
                            GeometryReader { geo in
                                VStack {
                                    Text("\(UIScreen.main.bounds.width)")
                                    Text("\(UIScreen.main.bounds.width)")
                                }
                                .padding(.horizontal)
                                .preference(key: CustomHeightPreferenceKey.self, value: geo.size.width - 50)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .padding(.bottom) // 50 is header height
                            }.frame(height: heightRect)
                        } label: {
                            WeatherScreenHeader(showDivider: false, imageSystemName: "sun.max", headerText: "УФ-Индекс")
                        }.onPreferenceChange(CustomHeightPreferenceKey.self) { value in
                            self.heightRect = value
                            print(heightRect)
                        }
                    } else {
                        WeatherRectangleView {
                            VStack {
                                Text("\(UIScreen.main.bounds.width)")
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                            .padding(.bottom) // 50 is header height
                            .frame(height: heightRect)
                        } label: {
                            WeatherScreenHeader(showDivider: false, imageSystemName: "sun.max", headerText: "УФ-Индекс")
                        }
                    }
                }
            }
        }.padding(.horizontal, 10).foregroundColor(.white).background(Color.blue.ignoresSafeArea()) 
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
            WeatherScreenHeader(showDivider: true, imageSystemName: "calendar", headerText: "Прогноз на 10 дн")
        }
    }
}
