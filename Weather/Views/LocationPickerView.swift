//
//  LocationPickerView.swift
//  Weather
//
//  Created by Артем Хлопцев on 01.05.2022.
//

import SwiftUI

struct LocationPickerView: View {
    @EnvironmentObject private var mapVM: MapViewModel
    @Binding var result: [SearchModel]
    @State private var showList = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(mapVM.userLocations, id: \.self) { location in
                        CityRectangleView(cityName: location.cityName, netVM: NetworkingViewModel(coords: location.coordinates, lang: mapVM.getLanguage()))
                            .padding(.horizontal, 5)
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Weather")
        }
    }
}

struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerView(result: .constant([]))
            .environmentObject(MapViewModel())
    }
}
extension LocationPickerView {
    private var searchListSection: some View {
        List(self.result, id: \.self) {place in
            VStack(alignment: .leading) {
                Button {
                    if !mapVM.userLocations.contains(where: { $0.coordinates == place.coordinates }) {
                        mapVM.userLocations.append(place)
                    }
                    //                    self.presentationMode.wrappedValue.dismiss()
                    result = []
                } label: {
                    Text(place.cityName)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}
