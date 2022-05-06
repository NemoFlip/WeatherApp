//
//  SearchBarView.swift
//  Weather
//
//  Created by Артем Хлопцев on 08.04.2022.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject private var mapVM: MapViewModel
    let noLocation: Bool
    @Environment(\.presentationMode) var presentationMode
    @Binding var result: [SearchModel]
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(result: $result)
            Divider()
            if !self.result.isEmpty {
                searchListSection
            }
            if noLocation {
                Spacer()
            
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension SearchBarView {
    private var searchListSection: some View {
        List(self.result, id: \.self) {place in
            VStack(alignment: .leading) {
                Button {
                    if !mapVM.userLocations.contains(where: { $0.coordinates == place.coordinates }) {
                        mapVM.userLocations.append(place)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                    result = []
                } label: {
                    Text(place.cityName)
                }
            }
        }
        .listStyle(PlainListStyle())
        .frame(minHeight: UIScreen.main.bounds.height / 15, maxHeight: UIScreen.main.bounds.height / 2)
    }
}
