//
//  WeatherRectangleView.swift
//  Weather
//
//  Created by Артем Хлопцев on 09.04.2022.
//

import SwiftUI

struct WeatherRectangleView<Content: View, Label: View>: View {
    let content: Content
    let label: Label
    let isSquare: Bool
    init(isSquare: Bool, @ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) {
        self.isSquare = isSquare
        self.content = content()
        self.label = label()
    }
    var body: some View {
        VStack(alignment: .leading, spacing: isSquare ? 3 : nil) {
            label
                .padding([.top, .horizontal])
            content
                .padding(.horizontal)
                .padding(.bottom)
        }.background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct WeatherRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRectangleView(isSquare: true) {
            Text("Hello world")
        } label: {
            Text("Some changes of the weather")
            Divider()
        }
        
    }
}
