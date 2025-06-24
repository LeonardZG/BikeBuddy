//
//  AddRideView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 21.05.25.
//

import SwiftUI

struct AddRideView: View {
    @EnvironmentObject var rideManager: RideManager
    @EnvironmentObject var challengeManager: ChallengeManager

    @State private var date: Date = Date()
    @State private var distance: Double = 0.0
    @State private var durationHours: Int = 0
    @State private var durationMinutes: Int = 0
    @State private var showConfirmation = false
    @FocusState private var isInputFocused: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                // Datum
                Section(header: Text("Datum der Fahrt")) {
                    DatePicker("Datum", selection: $date, displayedComponents: .date)
                }

                // Strecke
                Section(header: Text("Gefahrene Kilometer")) {
                    TextField("z. B. 15.5", value: $distance, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                }

                // Fahrzeit in Stunden & Minuten
                Section(header: Text("Fahrzeit")) {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Stunden")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            TextField("z. B. 2", value: $durationHours, format: .number)
                                .keyboardType(.numberPad)
                                .focused($isInputFocused)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Minuten")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            TextField("z. B. 45", value: $durationMinutes, format: .number)
                                .keyboardType(.numberPad)
                                .focused($isInputFocused)
                        }
                    }
                }


                // Speichern
                Button("Fahrt speichern") {
                    let totalMinutes = Double(durationHours * 60 + durationMinutes)
                    let newRide = Ride(date: date, distance: distance, durationInMinutes: totalMinutes)

                    rideManager.addRide(newRide)

                    // Zurücksetzen
                    date = Date()
                    distance = 0
                    durationHours = 0
                    durationMinutes = 0
                    isInputFocused = false
                    showConfirmation = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        dismiss()
                    }
                }
                .disabled(distance <= 0 || (durationHours == 0 && durationMinutes == 0))
                .buttonStyle(.borderedProminent)

                // Erfolgs-Feedback
                if showConfirmation {
                    Text("✅ Fahrt gespeichert")
                        .foregroundColor(.green)
                        .font(.caption)
                        .transition(.opacity)
                }
            }
            .navigationTitle("Fahrt hinzufügen")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fertig") {
                        isInputFocused = false
                    }
                }
            }
        }
    }
}
