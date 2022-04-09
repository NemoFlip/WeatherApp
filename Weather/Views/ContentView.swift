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
                    WeatherRectangleView {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<10) {item in
                                    VStack(spacing: 5) {
                                        Text("Now")
                                        Image(systemName: "cloud.fill")
                                        Text("7º")
                                    }
                                }
                            }.foregroundColor(.white).padding()
                        }
                    } label: {
                        VStack {
                            Text("Ожидается дождливая погода около 23:00")
                                .font(.callout).foregroundColor(.white)
                            Divider()
                                
                        }.padding(10)
                    }.padding(.horizontal, 20)

            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            Divider()
            HStack {
                Spacer(minLength: 0)
                Button {
                    
                } label: {
                    Image(systemName: "list.bullet")
                        .font(.title2).padding(.trailing)
                }
            }.padding(10).background(.ultraThinMaterial)
        }.background(Color.launchTheme.background.ignoresSafeArea(.all, edges: .all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
