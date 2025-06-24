//
//  AchievementManager.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 24.05.25.
//

import Foundation

class AchievementManager: ObservableObject {
    @Published var achievements: [Achievement] = []
    
    func updateAchievements(from rides: [Ride]) {
        let totalDistance = rides.reduce(0) { $0 + $1.distance }
        let count = rides.count
        
        DispatchQueue.main.async {
            self.achievements = [
                Achievement(
                    title: "Erste Fahrt",
                    description: "Du hast deine erste Fahrt abgeschlossen.",
                    isUnlocked: count >= 1
                ),
                Achievement(
                    title: "10 Fahrten",
                    description: "Du bist bereits 10 Mal gefahren!",
                    isUnlocked: count >= 10
                ),
                Achievement(
                    title: "100 Kilometer",
                    description: "Insgesamt 100 km erreicht.",
                    isUnlocked: totalDistance >= 100
                )
            ]
        }
    }
}
