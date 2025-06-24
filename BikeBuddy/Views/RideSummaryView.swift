//
//  RideSummaryView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 23.05.25.
//

import SwiftUI

struct RideSummaryView: View {
    let distance: Double
    let duration: TimeInterval
    let date: Date

    @EnvironmentObject var rideManager: RideManager
    @EnvironmentObject var challengeManager: ChallengeManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Text("Fahrt abgeschlossen")
                .font(.title2)
                .bold()

            VStack(spacing: 8) {
                Text("📅 \(formattedDate(date))")

                Text("🕒 Dauer: \(formatDuration(minutes: duration / 60))")

                Text("📏 Distanz: \(String(format: "%.2f", distance)) km")

                Text("🚴‍♂️ Ø-Geschwindigkeit: \(String(format: "%.1f", averageSpeed(distance: distance, durationMinutes: duration / 60))) km/h")
            }

            Button("Speichern") {
                let ride = Ride(date: date, distance: distance, durationInMinutes: duration / 60)
                rideManager.addRide(ride)

                // Fortschritt wird automatisch über filteredRides erkannt
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 16)

            Button("Verwerfen") {
                dismiss()
            }
            .foregroundColor(.red)
        }
        .padding()
        .navigationTitle("Fahrt speichern")
    }

    // MARK: - Hilfsfunktionen

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    private func formatDuration(minutes: Double) -> String {
        let total = Int(minutes)
        let h = total / 60
        let m = total % 60
        return "\(h) Std \(m) Min"
    }

    private func averageSpeed(distance: Double, durationMinutes: Double) -> Double {
        guard durationMinutes > 0 else { return 0 }
        return distance / (durationMinutes / 60)
    }
}
