//
//  WeatherScreenHeader.swift
//  Weather
//
//  Created by Артем Хлопцев on 14.04.2022.
//

import SwiftUI

struct WeatherScreenHeader: View {
    var showDivider: Bool
    var imageSystemName: String
    var headerText: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 3) {
                Image(systemName: imageSystemName)
                Text(headerText.uppercased())
                    
            }.font(.system(size: 14, weight: .semibold, design: .default))
                .secondaryText()
            
            if showDivider {
                Divider()
            }
        }
    }
}

struct WeatherScreenHeader_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreenHeader(showDivider: true, imageSystemName: "calendar", headerText: "Hour forecast")
    }
}
