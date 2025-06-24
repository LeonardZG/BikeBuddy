//
//  RideHistoryVie.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 22.05.25.
//

import SwiftUI

struct RideHistoryView: View {
    @EnvironmentObject var rideManager: RideManager

    var body: some View {
        NavigationStack {
            List {
                if rideManager.rides.isEmpty {
                    Text("Keine Fahrten gespeichert.")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    ForEach(sortedRides) { ride in
                        VStack(alignment: .leading) {
                            // Distanz + Zeit
                            Text("\(String(format: "%.1f", ride.distance)) km in \(formatDuration(minutes: ride.durationInMinutes))")
                                .font(.headline)

                            // Durchschnittsgeschwindigkeit
                            Text("Ø: \(String(format: "%.1f", averageSpeed(distance: ride.distance, durationMinutes: ride.durationInMinutes))) km/h")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            // Datum
                            Text(formattedDate(ride.date))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteRide) // 🗑 Swipe-to-delete
                }
            }
            .navigationTitle("Fahrtenübersicht")
        }
    }

    // Sortierung (neueste Fahrt zuerst)
    private var sortedRides: [Ride] {
        rideManager.rides.sorted { $0.date > $1.date }
    }

    // Datum formatieren
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    // Eintrag löschen
    private func deleteRide(at offsets: IndexSet) {
        rideManager.rides.remove(atOffsets: offsets)
        rideManager.saveRides()
    }

    // Durchschnittsgeschwindigkeit berechnen
    private func averageSpeed(distance: Double, durationMinutes: Double) -> Double {
        guard durationMinutes > 0 else { return 0 }
        return distance / (durationMinutes / 60)
    }

    // Zeitformat: 1 Std 30 Min
    private func formatDuration(minutes: Double) -> String {
        let total = Int(minutes)
        let h = total / 60
        let m = total % 60
        return "\(h) Std \(m) Min"
    }
}
