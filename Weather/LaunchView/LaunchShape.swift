//
//  LaunchShape.swift
//  Weather
//
//  Created by Артем Хлопцев on 02.04.2022.
//

import Foundation
import SwiftUI

struct LaunchShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let mid = rect.width / 2
            let height = rect.height
            path.move(to: CGPoint(x: rect.minX, y: 0))
            path.addLine(to: CGPoint(x: mid - 40, y: height))
            path.addLine(to: CGPoint(x: mid, y: height / 2))
            path.addLine(to: CGPoint(x: mid + 40, y: height))
            path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        }
    }
}

