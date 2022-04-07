//
//  HomeView.swift
//  Weather
//
//  Created by Артем Хлопцев on 05.04.2022.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @ObservedObject var mapVM: MapViewModel
    @State var result = [SearchModel]()
    var body: some View {
        VStack {
            Text(mapVM.userAddress)
                .font(.system(size: 28, weight: .semibold, design: .rounded))
                .padding(.top, 50)
                .foregroundColor(.white)
            VStack(spacing: 0) {
                SearchBar(region: $mapVM.region, result: $result)
                Divider()
                if !self.result.isEmpty {
                    List(self.result) {place in
                        VStack(alignment: .leading) {
                            Text(place.cityName)
                            
                        
                        }
                        
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: UIScreen.main.bounds.height / 2)
                } else {
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height / 2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 25)

        }.onAppear {
            mapVM.locationManager.delegate = mapVM
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(mapVM: MapViewModel())
    }
}
