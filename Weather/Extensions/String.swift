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

func getDateFromUNIX(timeOffset: Int, currentDate: Int, dateFormat: String) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(currentDate))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    dateFormatter.timeZone = TimeZone(secondsFromGMT: timeOffset)
    return dateFormatter.string(from: date)
}
