//
//  ContentView.swift
//  Weather
//
//  Created by Артем Хлопцев on 02.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State var endAnimation = false
    var body: some View {
        
        ZStack {
            Text("Hello, world!")
                .offset(y: endAnimation ? 0 : getRect().height)
            LaunchScreen(endAnimation: $endAnimation)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
