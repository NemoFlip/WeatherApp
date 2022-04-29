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
    static let theme = MainTheme()
}
struct LaunchTheme {
    let background = Color("LaunchBackgroundColor")
    let accent = Color("LaunchAccentColor")
}

struct MainTheme {
    let lightBlue = Color("LightBlue")
}
