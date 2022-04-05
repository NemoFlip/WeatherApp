//
//  View.swift
//  Weather
//
//  Created by Артем Хлопцев on 02.04.2022.
//

import SwiftUI
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}
