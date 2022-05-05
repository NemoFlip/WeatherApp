//
//  CityRectangleView.swift
//  Weather
//
//  Created by Артем Хлопцев on 04.05.2022.
//

import SwiftUI
import CoreLocation
struct CityRectangleView: View {
    let cityName: String
    @StateObject var netVM: NetworkingViewModel
    var body: some View {
        ZStack {
            Image(netVM.backImageName)
                .resizable()
                .scaledToFill()
                .frame(height: 110)
                .cornerRadius(20)
            HStack {
                VStack(alignment: .leading) {
                    Text(cityName)
                        .subTextSquare()
                    Text(getDateFromUNIX(timeOffset: netVM.weatherModel?.timezone_offset ?? 0, currentDate: netVM.weatherModel?.current.dt ?? 0, dateFormat: "HH:mm"))
                    Spacer()
                    Text(netVM.weatherModel?.current.weather[0].weatherDescription.firstCapitalized ?? "")
                        .smallInfoTextSquare()
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("\(Int(netVM.weatherModel?.current.temp ?? 0))º")
                        .bigInfoTextSquare()
                    Spacer()
                    Text("L: \(Int(round(netVM.weatherModel?.daily[0].temp.min ?? -1)))º  H: \(Int(round(netVM.weatherModel?.daily[0].temp.max ?? 0)))º")
                        .smallInfoTextSquare()
                }
            }
            .padding()
        }
        .frame(height: 110)
        .foregroundColor(.white)
        
    }
}

struct CityRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        CityRectangleView(cityName: "Moscow", netVM: NetworkingViewModel(coords: CLLocationCoordinate2D(latitude: 30, longitude: -25), lang: "en"))
    }
}
