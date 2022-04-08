//
//  HomeView.swift
//  Weather
//
//  Created by Артем Хлопцев on 05.04.2022.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject private var mapVM: MapViewModel
    @State var result = [SearchModel]()
    var body: some View {
        VStack {
            if !mapVM.userAddress.isEmpty {
                Text(mapVM.userAddress)
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .padding(.top, 50)
            } else {
                noLocationButtonSection
            }
            
        }.onAppear { mapVM.locationManager.delegate = mapVM }
        .sheet(isPresented: $mapVM.noLocation) {
            SearchBarView(result: $result)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.mapVM)
    }
}

extension HomeView {
    private var noLocationButtonSection: some View {
        Button {
            mapVM.noLocation.toggle()
        } label: {
            Text("Tap to select the city")
                .foregroundColor(.secondary)
        }
    }
}
