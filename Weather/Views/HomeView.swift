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
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    if !mapVM.userLocations.isEmpty {
                        Text(mapVM.userLocations[0].cityName)
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                    } else {
                        noLocationButtonSection
                    }
                }
            }
            tabBarSection
        }.background(Color.launchTheme.background.ignoresSafeArea())
        
        //        .onAppear { mapVM.locationManager.delegate = mapVM }
        //        .sheet(isPresented: $mapVM.noLocation) {
        //            SearchBarView(result: $result)
        //        }
        //        .environmentObject(mapVM)
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
            HStack {
                Spacer(minLength: 0)
                Button {
                    
                } label: {
                    Image(systemName: "list.bullet")
                        .font(.title2).padding(.trailing)
                        .foregroundColor(.white)
                }
            }.padding(10).background(.ultraThinMaterial)
        }.frame(maxHeight: .infinity, alignment: .bottom)
    }
}
