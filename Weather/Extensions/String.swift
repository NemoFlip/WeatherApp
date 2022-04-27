//
//  String.swift
//  Weather
//
//  Created by Артем Хлопцев on 27.04.2022.
//

import Foundation

extension StringProtocol {
    var firstCapitalized: String { return self.prefix(1).capitalized + dropFirst() }
}
