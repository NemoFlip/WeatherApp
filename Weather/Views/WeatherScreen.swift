//
//  WeatherScreen.swift
//  Weather
//
//  Created by Артем Хлопцев on 13.04.2022.
//

import SwiftUI

struct WeatherScreen: View {
    @State var offset: CGFloat = .zero
    var topEdge: CGFloat 
    @State var heightRect: CGFloat = .zero
    @Binding var name: String
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                headerSection
                    
                hourForecastSection
                
                weekForecastSection
                
                gridOfWeatherInfoSquares
            }
            .padding(.top, 25)
            .padding(.top, topEdge)
            .padding(.horizontal, 10)
            .overlay {
                GeometryReader { geo -> Color in
                    let minY = geo.frame(in: .global).minY
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    return Color.clear
                }
            }
            
        }
        .foregroundColor(.white)
        .background(Color.blue.ignoresSafeArea())
    }
    func getTitleOpactiy() -> CGFloat {
        let titleOffset = -getTitleOffset()
        let progress = titleOffset / 20
        let opacity = 1 - progress
        return opacity
    }
    func getTitleOffset() -> CGFloat {
        if offset < 0 {
            let progress = -offset / 120
            let newOffset = (progress <= 1.0 ? progress : 1) * 20 // top padding 25
            return -newOffset
        }
        return 0
    }
}
struct WeatherScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen(topEdge: .zero, name: .constant(""))
    }
}

extension WeatherScreen {
    private var headerSection: some View {
        VStack(spacing: 2) {
            Text(name.localizedCapitalized)
                .font(.system(size: 35, weight: .medium))
            HStack {
                Text("12º")
                Text("|")
                Text("Переменная облачность")
            }
            .opacity(-offset / 20 < 3 ? 0 : 1 - getTitleOpactiy())
            .font(.system(size: 20, weight: .medium))
            
            Text("12º")
                .opacity(getTitleOpactiy())
                .font(.system(size: 80, weight: .thin))
            Group {
                Text("Переменная облачность")
                Text("Макс.: 15º, мин.: 2º")
                    .padding(.bottom, 30)
            }
            .opacity(getTitleOpactiy())
            .font(.system(size: 15, weight: .medium))
            
        }
        .offset(y: -offset) // for staing on top
        .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)  // for dragging to bottom
        .offset(y: getTitleOffset())
    }
    private var hourForecastSection: some View {
        WeatherRectangleView(isSquare: false) {
            ScrollView(.horizontal ,showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<27) {item in
                        VStack(spacing: 10) {
                            Text("Now")
                            Image(systemName: "cloud.fill")
                            Text("11º")
                        }
                    }
                }
            }
            
        } label: {
            Text("Ожидается ясная погода около 19:00")
                .font(.subheadline)
            
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
            WeatherScreenHeader(imageSystemName: "calendar", headerText: "Прогноз на 10 дн")
        }
    }
    private var weatherInfoSquarePreference: some View {
        WeatherRectangleView(isSquare: true) {
            GeometryReader { geo in
                PressureView()
//                    .padding(4) // only for pressure
                    .preference(key: CustomHeightPreferenceKey.self, value: geo.size.width - 40) // 40 is header height
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }.frame(height: heightRect)
        } label: {
            WeatherScreenHeader(imageSystemName: "sun.max", headerText: "УФ-Индекс")
        }
        .onPreferenceChange(CustomHeightPreferenceKey.self) { self.heightRect = $0 }
    }
    private var weatherInfoSquare: some View {
        WeatherRectangleView(isSquare: true) {
            RainFallView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // .leading for all but WindView
                .frame(height: heightRect)
            
        } label: {
            WeatherScreenHeader(imageSystemName: "sun.max", headerText: "УФ-Индекс")
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
