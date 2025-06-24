//
//  AchievementView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 24.05.25.
//

import SwiftUI

struct AchievementView: View {
    @EnvironmentObject var achievementManager: AchievementManager

    var body: some View {
        List(achievementManager.achievements) { achievement in
            HStack {
                Image(systemName: achievement.isUnlocked ? "checkmark.seal.fill" : "lock.fill")
                    .foregroundColor(achievement.isUnlocked ? .green : .gray)

                VStack(alignment: .leading) {
                    Text(achievement.title).bold()
                    Text(achievement.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Erfolge")
    }
}
