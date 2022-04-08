//
//  PreviewProvider.swift
//  Weather
//
//  Created by Артем Хлопцев on 08.04.2022.
//

import Foundation
import SwiftUI
extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    let mapVM = MapViewModel()
}
