//
//  SquareViews.swift
//  Weather
//
//  Created by Артем Хлопцев on 18.04.2022.
//

import SwiftUI

struct UVIndexView: View {
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
                    Text("м/с")
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

struct SquareViews_Previews: PreviewProvider {
    static var previews: some View {
        WindView()
            .previewLayout(.sizeThatFits)
            .background(.red)
            .foregroundColor(.white)
    }
}

