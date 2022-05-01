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
    var body: some View {
        NavigationView {
                VStack {
                    SearchBarView(result: $result)
                    ForEach(mapVM.userLocations, id: \.self) { location in
                        Text(location.cityName)
                    }
                
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
