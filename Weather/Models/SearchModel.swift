//
//  SearchModel.swift
//  Weather
//
//  Created by Артем Хлопцев on 06.04.2022.
//

import Foundation
import CoreLocation

struct SearchModel: Identifiable {
    var id: Int
    var cityName: String
    var coordinates: CLLocationCoordinate2D
}
