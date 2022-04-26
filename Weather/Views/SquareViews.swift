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
            Text(getUVScale(uvi: networkingVM.weatherModel?.current.uvi))
                .subTextSquare()
            Spacer()
            Text("\(getUVScale(uvi: Double(getMidValueOfUVI()))) is max for the rest of the day.")
                .smallInfoTextSquare()
        }
    }
    func getUVScale(uvi: Double?) -> String {
        let uvi = Int(round(uvi ?? 0))
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
    func getMidValueOfUVI() -> Int {
        var midValue = 0.0
        for i in 0..<12 {
            print(networkingVM.weatherModel?.hourly[i].uvi)
            midValue += networkingVM.weatherModel?.hourly[i].uvi ?? 0
        }
        let res = Int(round(midValue)) / 12
        print(res)
        return res
    }
}

struct SunriseView: View {
    @EnvironmentObject private var networkingVM: NetworkingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(getDateStringFromUTC(time: networkingVM.weatherModel?.current.sunrise ?? 0, timeZoneOffset: networkingVM.weatherModel?.timezone_offset ?? 0))
                .bigInfoTextSquare()
            Spacer()
            Text("Sunset: \(getDateStringFromUTC(time: networkingVM.weatherModel?.current.sunset ?? 0, timeZoneOffset: networkingVM.weatherModel?.timezone_offset ?? 0))")
                .smallInfoTextSquare()
        }
    }
    func getDateStringFromUTC(time: Int, timeZoneOffset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZoneOffset)
        return dateFormatter.string(from: date)
    }
}

struct WindView: View {
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
            ZStack {
                Circle().fill(.ultraThinMaterial)
                    .shadow(radius: 1)
                
                VStack {
                    Text("3")
                        .subTextSquare()
                    Text("m/s")
                        .smallInfoTextSquare()
                }
            }.padding(20)
            
        }.padding(.top, 5)
    }
}

struct RainFallView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("6 mm")
                .bigInfoTextSquare()
            Text("in last 6h")
                .subTextSquare()
            Spacer()
            Text("1 mm expected in next 24h")
                .smallInfoTextSquare()
        }
    }
}
struct FeelsLikeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("6º")
                .bigInfoTextSquare()
            Spacer()
            Text("Wind is making it feel cooler")
                .smallInfoTextSquare()
        }
    }
}
struct HumidityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("44%")
                .bigInfoTextSquare()
            Spacer()
            Text("The dew point is -3º right now")
                .smallInfoTextSquare()
        }
    }
}
struct VisibilityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("16 km")
                .bigInfoTextSquare()
            Spacer()
            Text("It's perfectly clear right now")
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

