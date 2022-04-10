//
//  ContentView.swift
//  Weather
//
//  Created by Артем Хлопцев on 08.04.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            TabView {
                HomeView()
                
                Text("HELLO WORLD")
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            tabBarSection
            
            
        }.background(Color.launchTheme.background.ignoresSafeArea(.all, edges: .all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    var tabBarSection: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                Spacer(minLength: 0)
                Button {
                    
                } label: {
                    Image(systemName: "list.bullet")
                        .font(.title2).padding(.trailing)
                }
            }.padding(10).background(.ultraThinMaterial)
        }
    }
}

