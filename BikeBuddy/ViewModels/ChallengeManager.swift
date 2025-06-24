//
//  ChallengeManager.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 22.05.25.
//

import Foundation

class ChallengeManager: ObservableObject {
    @Published var availableChallenges: [Challenge] = []
    @Published var activeChallenges: [Challenge] = []

    init() {
        loadAvailableChallenges()
        loadActiveChallenges()
    }

    // MARK: - Laden

    private func loadAvailableChallenges() {
        let saved = StorageService.loadAvailableChallenges()
        
        var combined = predefinedChallenges

        for challenge in saved {
            if !combined.contains(where: { $0.id == challenge.id }) {
                combined.append(challenge)
            }
        }

        // Entferne alle, die bereits aktiv sind
        combined.removeAll { candidate in
            activeChallenges.contains(where: { $0.id == candidate.id })
        }

        availableChallenges = combined
    }

    private func loadActiveChallenges() {
        activeChallenges = StorageService.loadActiveChallenges()
    }

    // MARK: - Speichern

    private func saveAvailableChallenges() {
        StorageService.saveAvailableChallenges(availableChallenges)
    }
    private func saveActiveChallenges() {
        StorageService.saveActiveChallenges(activeChallenges)
    }

    // MARK: - Verwaltung

    func addChallenge(_ challenge: Challenge) {
        availableChallenges.append(challenge)
        saveAvailableChallenges()
    }

    func activateChallenge(_ challenge: Challenge) {
        if !activeChallenges.contains(where: { $0.id == challenge.id }) {
            activeChallenges.append(challenge)
            saveActiveChallenges()
        }
    }

    func removeAvailableChallenge(_ challenge: Challenge) {
        availableChallenges.removeAll { $0.id == challenge.id }
        saveAvailableChallenges()
    }
    
    func isChallengeFulfilled(_ challenge: Challenge, with rides: [Ride]) -> Bool {
        switch challenge.type {
        case .rideCount:
            let filtered = rides.filter {
                $0.date >= challenge.startDate && $0.date <= challenge.endDate
            }
            return filtered.count >= (challenge.targetRideCount ?? 0)

        case .speed:
            let qualified = rides.filter {
                let hours = $0.durationInMinutes / 60
                let speed = $0.distance / hours
                return hours >= 1 && speed >= (challenge.minAverageSpeed ?? 0)
            }
            return !qualified.isEmpty

        case .weekly, .monthly, .daily, .distance:
            let total = rides
                .filter { $0.date >= challenge.startDate && $0.date <= challenge.endDate }
                .reduce(0) { $0 + $1.distance }
            return total >= challenge.goalInKm

        default:
            return false
        }
    }
    
    func removeExpiredChallenges(with rides: [Ride]) {
        let now = Date()

        activeChallenges.removeAll { challenge in
            return now > challenge.endDate
        }
    }

    func removeActiveChallenge(_ challenge: Challenge) {
        activeChallenges.removeAll { $0.id == challenge.id }
        saveActiveChallenges()
    }

    // MARK: - Vordefinierte Challenges

    private var predefinedChallenges: [Challenge] {
        return [
            Challenge(name: "50 km diese Woche", goalInKm: 50, type: .weekly),
            Challenge(name: "100 km diesen Monat", goalInKm: 100, type: .monthly),
            Challenge(name: "200 km Challenge", goalInKm: 200, type: .monthly),
            Challenge(name: "10 Fahrten diese Woche", goalInKm: 0, type: .rideCount, targetRideCount: 10),
            Challenge(name: "25 km/h in 1 Std", goalInKm: 0, type: .speed, minAverageSpeed: 25)
        ]
    }
}

