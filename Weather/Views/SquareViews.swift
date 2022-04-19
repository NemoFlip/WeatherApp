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
                .font(.system(size: 27, weight: .medium, design: .default))
            Text("Low")
                .font(.system(size: 19, weight: .medium, design: .default))
            Text("Low for the rest of the day.")
                .font(.system(size: 14))
        }
    }
}

struct SunriseView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("04:31")
                .font(.system(size: 27, weight: .medium, design: .default))
            Spacer()
            Text("Sunset: 18:57")
                .font(.system(size: 14))
        }
    }
}

struct WindView: View {
    var body: some View {
        ZStack {
            ZStack {
                Text("N")
                    .font(.system(size: 11, weight: .heavy))
                    .frame(maxHeight: .infinity, alignment: .top)
                Circle().stroke(Color.white.opacity(0.5), style: StrokeStyle(lineWidth: 8, lineCap: .butt, lineJoin: .miter, miterLimit: .zero, dash: [1.3]))
                    .scaledToFit()
                Text("S")
                    .font(.system(size: 11, weight: .heavy))
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
                        .font(.system(size: 19, weight: .medium, design: .default))
                    Text("м/с")
                        .font(.system(size: 14))
                }
            }.padding(20)
            
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

