//
//  WeatherRectangleView.swift
//  Weather
//
//  Created by Артем Хлопцев on 09.04.2022.
//

import SwiftUI

struct WeatherRectangleView<Content: View, Label: View>: View {
    let content: Content
    @State var topOffset: CGFloat = 0
    @State var bottomOffset: CGFloat = 0
    let label: Label
    let isSquare: Bool
    init(isSquare: Bool, @ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) {
        self.isSquare = isSquare
        self.content = content()
        self.label = label()
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            label
                .frame(height: 34)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .background(.ultraThinMaterial, in: CustomCorner(corners: bottomOffset < 34 ? .allCorners : [.topLeft, .topRight], radius: 12))
                .zIndex(1.0)
            VStack {
                if !isSquare {
                    Divider()
                }
                content
                    .padding([.horizontal, .bottom])
                
            }
            .background(.ultraThinMaterial, in: CustomCorner(corners: [.bottomLeft, .bottomRight], radius: 12))
            .offset(y: topOffset >= 120 ? 0 :  -120 + topOffset)
            .zIndex(0.0)
            .clipped()
            .opacity(getOpacity())
        }
        .cornerRadius(12)
        .opacity(getOpacity())
        .offset(y: topOffset >= 120 ? 0 :  120 + -topOffset)
        .background(
            GeometryReader { geo -> Color in
                let min = geo.frame(in: .global).minY
                let max = geo.frame(in: .global).maxY
                DispatchQueue.main.async {
                    self.topOffset = min
                    self.bottomOffset = max - 120
                }
                return Color.clear
            }
        )
        .cornerRadius(12)
    }
    func getOpacity() -> CGFloat {
        if bottomOffset < 24 {
            let progress = bottomOffset / 24
            return progress
        }
        return 1
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
