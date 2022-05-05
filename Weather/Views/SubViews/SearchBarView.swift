//
//  SearchBarView.swift
//  Weather
//
//  Created by Артем Хлопцев on 08.04.2022.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject private var mapVM: MapViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var result: [SearchModel]
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(result: $result)
            Divider()
            if !self.result.isEmpty {
                searchListSection
            } else {
//                Spacer()
//                    .frame(height: UIScreen.main.bounds.height / 2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .padding(.horizontal, 25)
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
