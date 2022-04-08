//
//  WeatherApp.swift
//  Weather
//
//  Created by Артем Хлопцев on 02.04.2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject private var mapVM = MapViewModel()
    @State var endAnimation = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                VStack {
                    if !endAnimation {
                        LaunchScreen(endAnimation: $endAnimation)
                            .transition(.move(edge: .top))
                    }
                }
            }.environmentObject(mapVM)
        }
    }
}
