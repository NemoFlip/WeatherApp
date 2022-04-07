//
//  ContentView.swift
//  Weather
//
//  Created by Артем Хлопцев on 02.04.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var mapVM = MapViewModel()
    
    @State var endAnimation = false
    var body: some View {
        ZStack {
            HomeView(mapVM: mapVM)
            VStack {
                if !endAnimation {
                    LaunchScreen(endAnimation: $endAnimation)
                        .transition(.move(edge: .top))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

