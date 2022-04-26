//
//  SquareViews.swift
//  Weather
//
//  Created by Артем Хлопцев on 18.04.2022.
//

import SwiftUI
import CoreLocation
struct UVIndexView: View {
    @StateObject private var vm = NetworkingViewModel()
    //    @EnvironmentObject private var networkingVM: NetworkingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("0")
                .bigInfoTextSquare()
            Text("Low")
                .subTextSquare()
            Spacer()
            Text("Low for the rest of the day.")
                .smallInfoTextSquare()
        }
        .onAppear {
            vm.addSubscribers(coords: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423), lang: "en")
            
        }
    }
}

struct SunriseView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("04:31")
                .bigInfoTextSquare()
            Spacer()
            Text("Sunset: 18:57")
                .smallInfoTextSquare()
        }
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

