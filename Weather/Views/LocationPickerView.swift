//
//  LocationPickerView.swift
//  Weather
//
//  Created by Артем Хлопцев on 01.05.2022.
//

import SwiftUI

struct LocationPickerView: View {
    @AppStorage(UserLocationKeys.userLocationIndex) var locationIndex = 0
    @EnvironmentObject private var mapVM: MapViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var result: [SearchModel]
    @State private var showList = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBarView(noLocation: false, result: $result)
                    
                    weatherScreensSection
                    
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    private var weatherScreensSection: some View {
        ForEach(mapVM.userLocations, id: \.self) { location in
            Button {
                locationIndex = mapVM.userLocations.firstIndex(of: location) ?? 0
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                CityRectangleView(cityName: location.cityName, netVM: NetworkingViewModel(coords: location.coordinates, lang: mapVM.getLanguage()))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 5)
                
            }
        }
    }
}
