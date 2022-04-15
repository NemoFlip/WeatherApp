//
//  CustomHeightPreferenceKey.swift
//  Weather
//
//  Created by Артем Хлопцев on 15.04.2022.
//

import Foundation
import SwiftUI

struct CustomHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    } 
}
