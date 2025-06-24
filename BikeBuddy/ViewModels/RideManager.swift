//
//  RideManager.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 22.05.25.
//

import Foundation

class RideManager: ObservableObject {
    @Published var rides: [Ride] = []
    
    init() {
        loadRides()
    }
    
    private var achievementManager: AchievementManager?
    private var challengeManager: ChallengeManager?

        init(
            achievementManager: AchievementManager? = nil,
            challengeManager: ChallengeManager? = nil ) {
            self.achievementManager = achievementManager
            loadRides()
            achievementManager?.updateAchievements(from: rides)
        }

    private func loadRides() {
        rides = StorageService.loadRides()
    }

    func saveRides() {
        StorageService.saveRides(rides)
    }

    func addRide(_ ride: Ride) {
        rides.append(ride)
        saveRides()
        achievementManager?.updateAchievements(from: rides)
        challengeManager?.removeExpiredChallenges(with: rides)
    }

    var totalDistance: Double {
        rides.reduce(0) { $0 + $1.distance }
    }
}
