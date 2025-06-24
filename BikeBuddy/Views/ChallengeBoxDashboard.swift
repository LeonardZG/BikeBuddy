//
//  ChallengeBoxDashboard.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 25.05.25.
//

import SwiftUI

struct ChallengeBoxDashboard: View {
    @EnvironmentObject var challengeManager: ChallengeManager
    @EnvironmentObject var rideManager: RideManager
    let challenge: Challenge

    var body: some View {
        let rides = rideManager.rides.filter {
            $0.date >= challenge.startDate && $0.date <= challenge.endDate
        }

        let (progressValue, progressLabel) = computeProgress(for: challenge, with: rides)
        let fulfilled = challengeManager.isChallengeFulfilled(challenge, with: rideManager.rides)

        return NavigationLink(destination: ChallengeDetailView(challenge: challenge)) {
            VStack(alignment: .leading, spacing: 6) {
                Text(fulfilled ? "✅ \(challenge.name)" : challenge.name)
                    .font(.headline)
                    .foregroundColor(fulfilled ? .green : .primary)

                ProgressView(value: progressValue)
                    .tint(fulfilled ? .gray : .green)

                Text(progressLabel)
                    .font(.caption)

                Text("Endet am: \(formattedDate(challenge.endDate))")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(fulfilled ? Color.gray.opacity(0.1) : Color.green.opacity(0.1))
            .cornerRadius(8)
        }
    }

    private func computeProgress(for challenge: Challenge, with rides: [Ride]) -> (Double, String) {
        switch challenge.type {
        case .rideCount:
            let count = rides.count
            let target = Double(challenge.targetRideCount ?? 1)
            return (min(Double(count) / target, 1.0), "\(count) / \(Int(target)) Fahrten")

        case .speed:
            let fulfilled = challengeManager.isChallengeFulfilled(challenge, with: rideManager.rides)
            return (fulfilled ? 1.0 : 0.0, fulfilled ? "✓ erfüllt" : "Noch nicht erfüllt")

        default:
            let total = rides.reduce(0) { $0 + $1.distance }
            let target = challenge.goalInKm
            return (target > 0 ? min(total / target, 1.0) : 0, "\(Int(total)) / \(Int(target)) km")
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
