//
//  HomeView.swift
//  Weather
//
//  Created by Артем Хлопцев on 05.04.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var mapVM: MapViewModel
    var body: some View {
        Color.red
                .ignoresSafeArea()
            VStack {
                Text(mapVM.userAddress)
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .padding(.top, 50)
                    .foregroundColor(.white)
                Spacer()
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
