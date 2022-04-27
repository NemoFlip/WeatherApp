//
//  SquareViews.swift
//  Weather
//
//  Created by Артем Хлопцев on 18.04.2022.
//

import SwiftUI
import CoreLocation
struct UVIndexView: View {
    @EnvironmentObject private var networkingVM: NetworkingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(Int(round(networkingVM.weatherModel?.current.uvi ?? 0)))")
                .bigInfoTextSquare()
            Text(getUVScale())
                .subTextSquare()
            Spacer()
            Text("\(getUVScale()) for the rest of the day.")
                .smallInfoTextSquare()
        }
    }
    func getUVScale() -> String {
        let uvi = Int(round(networkingVM.weatherModel?.current.uvi ?? 0))
        switch uvi {
        case 0...2:
            return "Low"
        case 3...5:
            return "Medium"
        case 6, 7:
            return "High"
        default:
            return "Very High"
        }
    }
}

struct SunriseView: View {
    @EnvironmentObject private var networkingVM: NetworkingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(getDateStringFromUTC(time: networkingVM.weatherModel?.daily[1].sunrise ?? 0))
                .bigInfoTextSquare()
            Spacer()
            Text("Sunset: \(getDateStringFromUTC(time: networkingVM.weatherModel?.current.sunset ?? 0))")
                .smallInfoTextSquare()
        }
    }
    func getRoundOfSecondsAmount(date: String) -> Int {
        guard let seconds = Int(date[date.index(date.endIndex, offsetBy: -2)...]) else { return 0 }
        if seconds >= 40 {
            return 60 - seconds
        }
        return 0
    }
    func getDateStringFromUTC(time: Int) -> String {
        let timeZoneOffset = networkingVM.weatherModel?.timezone_offset ?? 0
        var date = Date(timeIntervalSince1970: TimeInterval(time))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZoneOffset)
        date.addTimeInterval(TimeInterval(getRoundOfSecondsAmount(date: dateFormatter.string(from: date))))
        
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct WindView: View {
    @EnvironmentObject private var networkingVM: NetworkingViewModel
    var body: some View {
        ZStack {
            ZStack {
                Text("N")
                    .thickSmallText()
                    .secondaryText()
                    .frame(maxHeight: .infinity, alignment: .top)
                Circle().stroke(Color.white.opacity(0.5), style: StrokeStyle(lineWidth: 8, lineCap: .butt, lineJoin: .miter, miterLimit: .zero, dash: [1.3]))
                    .scaledToFit()
                Text("S")
                    .thickSmallText()
                    .secondaryText()
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            ArrowShape()
                .stroke(.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .scaledToFit()
                .rotationEffect(.degrees(-Double(networkingVM.weatherModel?.current.windDeg  ?? 0) + 90))
            ZStack {
                Circle().fill(.ultraThinMaterial)
                    .shadow(radius: 1)
                VStack {
                    Text("\(Int(round(networkingVM.weatherModel?.current.windSpeed ?? 0)))")
                        .subTextSquare()
                    Text("m/s")
                        .smallInfoTextSquare()
                }
            }.padding(20)
            
        }.padding(.top, 5)
    }
}

struct RainFallView: View {
    @EnvironmentObject private var networkingVM: NetworkingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(Int(ceil(networkingVM.weatherModel?.current.rain?.the1H ?? 0))) mm")
                .bigInfoTextSquare()
            Text("in last 1h")
                .subTextSquare()
            Spacer()
            Text("\(Int(ceil(networkingVM.weatherModel?.daily[0].rain ?? 0))) mm expected in next 24h")
                .smallInfoTextSquare()
            
        }
    }
}
struct FeelsLikeView: View {
    @EnvironmentObject private var networkingVM: NetworkingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(Int(round(networkingVM.weatherModel?.current.feelsLike ?? 0)))º")
                .bigInfoTextSquare()
            Spacer()
            Text("Wind is making it feel cooler")
                .smallInfoTextSquare()
        }
    }
}
struct HumidityView: View {
    @EnvironmentObject private var networkingVM: NetworkingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(networkingVM.weatherModel?.current.humidity ?? 0)%")
                .bigInfoTextSquare()
            Spacer()
            Text("The dew point is \(Int(round(networkingVM.weatherModel?.current.dewPoint ?? 0)))º right now")
                .smallInfoTextSquare()
        }
    }
}
struct VisibilityView: View {
    @EnvironmentObject private var networkingVM: NetworkingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\((networkingVM.weatherModel?.current.visibility ?? 0) / 1000) km")
                .bigInfoTextSquare()
            Spacer()
            Text("It's perfectly clear right now")
        }
    }
    func getVisibilityDescription() -> String {
        let visibility = networkingVM.weatherModel?.current.visibility ?? 0
        switch visibility {
        case ...200:
            return "thick fog"
        case 201...500:
            return "moderate fog"
        case 501...1000:
            return "light fog"
        case 1001...2000:
            return "thin fog"
        case 2001...4000:
            return "haze"
        case 4001...7000:
            return "light haze"
        case 7001...8500:
            return "clear"
        default:
            return "perfectly clear"
        }
    }
}
struct PressureView: View {
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.252, to: 1).stroke(Color.white.opacity(0.5), style: StrokeStyle(lineWidth: 9, lineCap: .butt, lineJoin: .miter, dash: [2, 5]))
                .rotationEffect(.degrees(46))
                .overlay {
                    Circle().trim(from: 0.95, to: 1).stroke(Color.white.opacity(0.5), style: StrokeStyle(lineWidth: 9)).foregroundStyle(.blue) // change first param in trim to controll filling
                        .rotationEffect(.degrees(46))
                }
            
            HStack(spacing: 15) {
                Text("Low")
                Text("High")
            }
            .smallInfoTextSquare()
            .frame(maxHeight: .infinity, alignment: .bottom)
            VStack(spacing: 0) {
                Image(systemName: "arrow.down").subTextSquare()
                Text("765").subTextSquare()
                Text("mm Hg").smallInfoTextSquare()
            }.padding(.bottom)
        }.padding(.top, 5)
    }
}
struct SquareViews_Previews: PreviewProvider {
    static var previews: some View {
        WindView()
            .previewLayout(.sizeThatFits)
            .background(.red)
            .foregroundColor(.white)
    }
}

