//
//  HomeView.swift
//  Weather
//
//  Created by Артем Хлопцев on 05.04.2022.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @StateObject var mapVM = MapViewModel()
    @State var result = [SearchModel]()
    var body: some View {
        ZStack {
            VStack {
                if !mapVM.userLocations.isEmpty {
                    GeometryReader { geo in
                        let top = geo.safeAreaInsets.top
                        WeatherScreen(topEdge: top, name: $mapVM.userLocations[0].cityName)
                            .ignoresSafeArea(.all, edges: .top)
                    }
                    
                } else {
                    noLocationButtonSection
                }
            }
            tabBarSection
        }
        .onAppear { mapVM.locationManager.delegate = mapVM }
        .sheet(isPresented: $mapVM.noLocation) {
            SearchBarView(result: $result)
        }
        .environmentObject(mapVM)
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
    private var tabBarSection: some View {
        VStack(spacing: 0) {
            Divider()
                .frame(height: 2)
            HStack {
                Spacer(minLength: 0)
                Button {
                    
                } label: {
                    Image(systemName: "list.bullet")
                        .font(.title2).padding(.trailing)
                        .foregroundColor(.white)
                }
            }.padding(8).background(.ultraThinMaterial)
        }.frame(maxHeight: .infinity, alignment: .bottom)
    }
}
