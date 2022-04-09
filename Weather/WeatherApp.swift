//
//  WeatherApp.swift
//  Weather
//
//  Created by Артем Хлопцев on 02.04.2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    @State var endAnimation = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                VStack {
                    if !endAnimation {
                        LaunchScreen(endAnimation: $endAnimation)
                            .transition(.move(edge: .top))
                    }
                }
            }
        }
    }
}
