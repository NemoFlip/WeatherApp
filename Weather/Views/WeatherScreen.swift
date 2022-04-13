//
//  WeatherScreen.swift
//  Weather
//
//  Created by Артем Хлопцев on 13.04.2022.
//

import SwiftUI

struct WeatherScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 2) {
                
                Text("Альметьевск")
                    .font(.system(size: 28, weight: .regular, design: .default))
                Text("12º")
                    .font(.system(size: 80, weight: .thin, design: .default))
                Group {
                    Text("Переменная облачность")
                    Text("Макс.: 15º, мин.: 2º")
                        .padding(.bottom, 30)
                }.font(.system(size: 15, weight: .medium, design: .default))
                
            }.padding(.top, 50).frame(maxWidth: .infinity, maxHeight: .infinity)
            WeatherRectangleView {
                ScrollView(.horizontal ,showsIndicators: false) {
                    HStack {
                        ForEach(0..<10) {item in
                            VStack(spacing: 8) {
                                Text("Now")
                                Image(systemName: "cloud.fill")
                                Text("11º")
                            }
                        }
                    }
                    
                }.padding(.horizontal).padding(.bottom)
            } label: {
                VStack(alignment: .leading) {
                    Text("Ожидается ясная погода около 19:00")
                        .font(.subheadline)
                    Divider()
                }.padding()
            }
            
            
            WeatherRectangleView {
                VStack(alignment: .leading) {
                    ForEach(0..<11) { item in
                        VStack(alignment: .leading) {
                            HStack(spacing: 35) {
                                Text("Сегодня")
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                Spacer()
                                Image(systemName: "sun.max.fill")
                                Spacer()
                                Text("2º")
                                    .foregroundColor(Color.white.opacity(0.7))
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                Text("19º")
                                    .font(.system(size: 18, weight: .medium, design: .default))
                            }
                            if item != 10 {
                                Divider()
                            }
                        }
                    }
                }.padding(.horizontal).padding(.bottom)
            } label: {
                VStack(alignment: .leading) {
                    Text("Прогноз на 10 дн")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white.opacity(0.7))
                    Divider()
                }.padding()
            }
            
            
        }.padding(.horizontal, 10).foregroundColor(.white).background(Color.blue.ignoresSafeArea())
    }
}

struct WeatherScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen()
    }
}
