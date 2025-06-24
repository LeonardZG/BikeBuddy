//
//  StorageService.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 22.05.25.
//

import Foundation

struct StorageService {
    private static let availableChallengesKey = "availableChallenges"

    static func saveAvailableChallenges(_ challenges: [Challenge]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(challenges) {
            UserDefaults.standard.set(data, forKey: availableChallengesKey)
        }
    }

    static func loadAvailableChallenges() -> [Challenge] {
        guard let data = UserDefaults.standard.data(forKey: availableChallengesKey) else {
            return []
        }

        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([Challenge].self, from: data) {
            return decoded
        }

        return []
    }
    
    private static let activeChallengesKey = "activeChallenges"

    static func saveActiveChallenges(_ challenges: [Challenge]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(challenges) {
            UserDefaults.standard.set(data, forKey: activeChallengesKey)
        }
    }

    static func loadActiveChallenges() -> [Challenge] {
        guard let data = UserDefaults.standard.data(forKey: activeChallengesKey) else {
            return []
        }

        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([Challenge].self, from: data) {
            return decoded
        }

        return []
    }
    
    private static let ridesKey = "rides"

    static func saveRides(_ rides: [Ride]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(rides) {
            UserDefaults.standard.set(data, forKey: ridesKey)
        }
    }

    static func loadRides() -> [Ride] {
        guard let data = UserDefaults.standard.data(forKey: ridesKey) else {
            return []
        }

        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([Ride].self, from: data) {
            return decoded
        }

        return []
    }

}
