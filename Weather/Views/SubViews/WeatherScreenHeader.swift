//
//  WeatherScreenHeader.swift
//  Weather
//
//  Created by Артем Хлопцев on 14.04.2022.
//

import SwiftUI

struct WeatherScreenHeader: View {
    var imageSystemName: String
    var headerText: String
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: imageSystemName)
            Text(headerText.uppercased())
            
        }
        .thickSmallText()
        .secondaryText()
    }
}

struct WeatherScreenHeader_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreenHeader(imageSystemName: "calendar", headerText: "Hour forecast")
    }
}
