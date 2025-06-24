//
//  Ride.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 22.05.25.
//

import Foundation

struct Ride: Identifiable, Codable {
    let id: UUID
    var date: Date
    var distance: Double
    var durationInMinutes: Double

    init(id: UUID = UUID(), date: Date = Date(), distance: Double, durationInMinutes: Double) {
        self.id = id
        self.date = date
        self.distance = distance
        self.durationInMinutes = durationInMinutes
    }
}
