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
struct BigInfoText: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 28, weight: .medium))
    }
}
struct SmallInfoText: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 14))
    }
}
struct ThickSmallText: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 14, weight: .semibold))
    }
}
struct SubTextSquare: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 19, weight: .medium))
    }
}
extension View {
    func secondaryText() -> some View {
        modifier(SecondaryModifier())
    }
    func bigInfoTextSquare() -> some View {
        modifier(BigInfoText())
    }
    func smallInfoTextSquare() -> some View {
        modifier(SmallInfoText())
    }
    func thickSmallText() -> some View {
        modifier(ThickSmallText())
    }
    func subTextSquare() -> some View {
        modifier(SubTextSquare())
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 5, y: rect.midY))
            path.addArc(center: CGPoint(x: 0, y: rect.midY), radius: 4, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
            path.move(to: CGPoint(x: 5, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            path.addLine(to: CGPoint(x: rect.maxX - 8, y: rect.midY - 3))
            path.addLine(to: CGPoint(x: rect.maxX - 8, y: rect.midY + 3))
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX - 8, y: rect.midY + 3))
        }
    }
}
