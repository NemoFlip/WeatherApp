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
            Spacer()
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

struct SquareViews_Previews: PreviewProvider {
    static var previews: some View {
        UVIndexView()
            .previewLayout(.sizeThatFits)
            .background(.black)
            .foregroundColor(.white)
    }
}
