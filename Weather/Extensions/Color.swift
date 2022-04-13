//
//  Color.swift
//  Weather
//
//  Created by Артем Хлопцев on 02.04.2022.
//

import Foundation
import SwiftUI
extension Color {
    static let launchTheme = LaunchTheme()
}
struct LaunchTheme {
    let background = Color("LaunchBackgroundColor")
    let accent = Color("LaunchAccentColor")
}
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
