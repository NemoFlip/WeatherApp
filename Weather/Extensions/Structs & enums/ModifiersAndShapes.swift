//
//  CustomModifiers.swift
//  Weather
//
//  Created by Артем Хлопцев on 17.04.2022.
//

import SwiftUI

struct SecondaryModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundColor(Color.white.opacity(0.7))
    }
}

extension View {
    func secondaryText() -> some View {
        modifier(SecondaryModifier())
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            path.addLine(to: CGPoint(x: rect.maxX - 8, y: rect.midY - 3))
            path.addLine(to: CGPoint(x: rect.maxX - 8, y: rect.midY + 3))
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX - 8, y: rect.midY + 3))
        }
    }
}
