//
//  WeatherScreen.swift
//  Weather
//
//  Created by Артем Хлопцев on 13.04.2022.
//

import SwiftUI
import CoreLocation
struct WeatherScreen: View {
    @StateObject var networkingVM: NetworkingViewModel
    var topEdge: CGFloat
    @Binding var name: String
    @State var offset: CGFloat = .zero
    @State var heightRect: CGFloat = .zero
    init(coords: CLLocationCoordinate2D, lang: String, topEdge: CGFloat, name: Binding<String>) {
        self.topEdge = topEdge
        self._name = name
        _networkingVM = StateObject(wrappedValue: NetworkingViewModel(coords: coords, lang: lang))
    }
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
        .environmentObject(networkingVM)
        .foregroundColor(.white)
        .background(
            Image(networkingVM.backImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
//                .overlay(.thinMaterial)
        )
//        .background(networkingVM.backColor.ignoresSafeArea())
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
        WeatherScreen(coords: CLLocationCoordinate2D(latitude: 0, longitude: 0), lang: "", topEdge: .zero, name: .constant(""))
    }
}

extension WeatherScreen {
    private var headerSection: some View {
        VStack(spacing: 2) {
            Text(name.localizedCapitalized)
                .font(.system(size: 35, weight: .medium))
            HStack {
                Text("\(Int(networkingVM.weatherModel?.current.temp ?? 0))º")
                Text("|")
                Text(networkingVM.weatherModel?.current.weather[0].weatherDescription.firstCapitalized ?? "")
            }
            .opacity(-offset / 20 < 3 ? 0 : 1 - getTitleOpactiy())
            .font(.system(size: 20, weight: .medium))
            
            Text("\(Int(networkingVM.weatherModel?.current.temp ?? 0))º")
                .opacity(getTitleOpactiy())
                .font(.system(size: 80, weight: .thin))
            Group {
                Text(networkingVM.weatherModel?.current.weather[0].weatherDescription.firstCapitalized ?? "")
                Text("H: \(Int(round(networkingVM.weatherModel?.daily[0].temp.max ?? 0)))º  L: \(Int(round(networkingVM.weatherModel?.daily[0].temp.min ?? -1)))º")
                    .padding(.bottom, 30)
            }
            .opacity(getTitleOpactiy())
            .font(.system(size: 18))
            
        }
        .offset(y: -offset) // for staing on top
        .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)  // for dragging to bottom
        .offset(y: getTitleOffset())
    }
    private var hourForecastSection: some View {
        WeatherRectangleView(isSquare: false) {
            ScrollView(.horizontal ,showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(networkingVM.weatherModel?.hourly ?? [WeatherScreen.dev.hourlyModel], id: \.self) { hourlyModel in
                        HourlyForecastRow(hourlyModel: hourlyModel, timeOffset: networkingVM.weatherModel?.timezone_offset ?? 0)
                    }
                }
            }
            
        } label: {
            WeatherScreenHeader(imageSystemName: "clock", headerText: "hourly forecast")
            
        }
    }
    private var weekForecastSection: some View {
        WeatherRectangleView(isSquare: false) {
            VStack(alignment: .leading) {
                ForEach(0..<(networkingVM.weatherModel?.daily.count ?? 0), id: \.self) { item in
                    WeekForecastRow(item: item, model: networkingVM.weatherModel?.daily[item] ?? WeatherScreen.dev.dailyModel, timeZoneOffset: networkingVM.weatherModel?.timezone_offset ?? 0)
                }
            }
        } label: {
            WeatherScreenHeader(imageSystemName: "calendar", headerText: "8-day forecast")
        }
    }
    private var gridOfWeatherInfoSquares: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 8),
            GridItem(.flexible())
        ], alignment: .center, spacing: 8) {
            ForEach(WeatherSquareInfo.allCases) { item in
                WeatherRectangleView(isSquare: true) {
                    if item == .UVIndex {
                        GeometryReader { geo in
                            item.view
                                .preference(key: CustomHeightPreferenceKey.self, value: geo.size.width - 40) // 40 is header height
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        }
                        .frame(height: heightRect)
                        .onPreferenceChange(CustomHeightPreferenceKey.self) { self.heightRect = $0 }
                    } else {
                        item.view
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // .leading for all but WindView
                            .frame(height: heightRect)
                    }
                } label: {
                    WeatherScreenHeader(imageSystemName: item.imageName, headerText: item.name)
                }
                
                
            }
        }
        .padding(.bottom, 50)
    }
}
