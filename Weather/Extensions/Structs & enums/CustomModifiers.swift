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
