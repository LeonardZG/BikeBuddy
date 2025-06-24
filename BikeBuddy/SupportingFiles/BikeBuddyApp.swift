//
//  BikeBuddyApp.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 21.05.25.
//

import SwiftUI

@main
struct BikeBuddyApp: App {
    @StateObject var challengeManager = ChallengeManager()
    @StateObject var achievementManager = AchievementManager()
    @StateObject var rideManager: RideManager

    init() {
        let challengeManager = ChallengeManager()
        let achievementManager = AchievementManager()
        _challengeManager = StateObject(wrappedValue: challengeManager)
        _achievementManager = StateObject(wrappedValue: achievementManager)
        _rideManager = StateObject(wrappedValue: RideManager(
            achievementManager: achievementManager,
            challengeManager: challengeManager
        ))
    }


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(rideManager)
                .environmentObject(challengeManager)
                .environmentObject(achievementManager)
        }
    }
}
