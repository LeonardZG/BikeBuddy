//
//  Challenge.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 22.05.25.
//

import Foundation

struct Challenge: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var goalInKm: Double
    var startDate: Date
    var endDate: Date
    var type: ChallengeType
    var targetRideCount: Int?     // z. B. 10
    var minAverageSpeed: Double?  // z. B. 25 km/h


    init(
        id: UUID = UUID(),
        name: String,
        goalInKm: Double,
        type: ChallengeType,
        targetRideCount: Int? = nil,
        minAverageSpeed: Double? = nil
    ) {
        self.id = id
        self.name = name
        self.goalInKm = goalInKm
        self.type = type
        self.targetRideCount = targetRideCount
        self.minAverageSpeed = minAverageSpeed

        switch type {
        case .weekly:
            self.startDate = Date().startOfWeek
            self.endDate = Date().endOfWeek
        case .monthly:
            self.startDate = Date().startOfMonth
            self.endDate = Date().endOfMonth
        case .daily:
            self.startDate = Date().startOfDay
            self.endDate = Date().endOfDay
        default:
            self.startDate = Date()
            self.endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        }
    }

    var isActive: Bool {
        let now = Date()
        return now >= startDate && now <= endDate
    }

    var durationInDays: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }
}
