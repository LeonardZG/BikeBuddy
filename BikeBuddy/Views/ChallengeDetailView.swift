//
//  ChallengeDetailView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 22.05.25.
//

import SwiftUI

struct ChallengeDetailView: View {
    let challenge: Challenge

    @EnvironmentObject var rideManager: RideManager
    @EnvironmentObject var challengeManager: ChallengeManager

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(challenge.name)
                        .font(.title2)
                        .bold()

                    // Kreisdiagramm
                    ProgressCircle(progress: progress)
                        .frame(width: 200, height: 200)
                        .padding()

                    // Challenge-Infos
                    Text("Ziel: \(Int(challenge.goalInKm)) km")
                    Text("Gefahren: \(String(format: "%.1f", totalDistance)) km")
                    Text("Zeitraum: \(formattedDate(challenge.startDate)) – \(formattedDate(challenge.endDate))")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    // Challenge löschen
                    Button(role: .destructive) {
                        challengeManager.removeActiveChallenge(challenge)
                    } label: {
                        Label("Challenge löschen", systemImage: "trash")
                    }

                    Divider()

                    // Rides in Challenge
                    Text("Fahrten in dieser Challenge")
                        .font(.headline)

                    if filteredRides.isEmpty {
                        Text("Noch keine Fahrten im Challenge-Zeitraum.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(filteredRides) { ride in
                            VStack(alignment: .leading) {
                                Text("\(String(format: "%.1f", ride.distance)) km in \(formatDuration(minutes: ride.durationInMinutes))")

                                Text("Ø \(String(format: "%.1f", averageSpeed(distance: ride.distance, durationMinutes: ride.durationInMinutes))) km/h")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                Text(formattedDate(ride.date))
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Challenge-Details")
        }
    }

    // MARK: - Datenberechnung

    private var filteredRides: [Ride] {
        rideManager.rides.filter { $0.date >= challenge.startDate && $0.date <= challenge.endDate }
    }

    private var totalDistance: Double {
        filteredRides.reduce(0) { $0 + $1.distance }
    }

    private var progress: Double {
        min(totalDistance / challenge.goalInKm, 1.0)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    private func averageSpeed(distance: Double, durationMinutes: Double) -> Double {
        guard durationMinutes > 0 else { return 0 }
        return distance / (durationMinutes / 60)
    }

    private func formatDuration(minutes: Double) -> String {
        let total = Int(minutes)
        let h = total / 60
        let m = total % 60
        return "\(h) Std \(m) Min"
    }

    // MARK: - Fortschrittskreis

    struct ProgressCircle: View {
        let progress: Double

        // Sicherer Prozentwert: 0–100 oder 0 bei ungültigem Input
        private var safePercentage: Int {
            if progress.isNaN || progress.isInfinite {
                return 0
            }
            return Int((min(max(progress, 0), 1)) * 100)
        }

        private var safeProgress: Double {
            if progress.isNaN || progress.isInfinite {
                return 0
            }
            return min(max(progress, 0), 1)
        }

        var body: some View {
            ZStack {
                // Hintergrund-Kreis
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.2)
                    .foregroundColor(.green)

                // Fortschritts-Kreis
                Circle()
                    .trim(from: 0.0, to: safeProgress)
                    .stroke(
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .foregroundColor(.green)
                    .rotationEffect(.degrees(-90))

                // Prozentzahl in der Mitte
                Text("\(safePercentage) %")
                    .font(.title2)
                    .bold()
            }
        }
    }
}
