//
//  AddChallengeView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 22.05.25.
//

import SwiftUI

struct AddChallengeView: View {
    @EnvironmentObject var challengeManager: ChallengeManager

    @State private var name: String = ""
    @State private var goalInKm: Double = 50
    @State private var selectedType: ChallengeType = .weekly
    @State private var minAverageSpeed: Double = 25
    @State private var targetRideCount: Int = 10

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Challenge-Name")) {
                    TextField("z. B. 100 km diesen Monat", text: $name)
                }

                // Typ-Auswahl
                Section(header: Text("Typ")) {
                    Picker(selection: $selectedType) {
                        Text("Wöchentlich").tag(ChallengeType.weekly)
                        Text("Monatlich").tag(ChallengeType.monthly)
                        Text("Täglich").tag(ChallengeType.daily)
                        Text("Fahrtenanzahl").tag(ChallengeType.rideCount)
                        Text("Durchschnittsgeschwindigkeit").tag(ChallengeType.speed)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.inline)
                }

                // Zielangabe
                if selectedType == .rideCount {
                    Section(header: Text("Fahrten-Ziel")) {
                        TextField("z. B. 10 Fahrten", value: $targetRideCount, format: .number)
                            .keyboardType(.numberPad)
                    }
                } else if selectedType == .speed {
                    Section(header: Text("Min. Durchschnittsgeschwindigkeit")) {
                        TextField("z. B. 25 km/h", value: $minAverageSpeed, format: .number)
                            .keyboardType(.decimalPad)
                    }
                } else {
                    Section(header: Text("Ziel (in km)")) {
                        TextField("z. B. 75", value: $goalInKm, format: .number)
                            .keyboardType(.decimalPad)
                    }
                }

                // Hinzufügen
                Button("Challenge hinzufügen") {
                    let newChallenge = Challenge(
                        name: name,
                        goalInKm: selectedType == .rideCount || selectedType == .speed ? 0 : goalInKm,
                        type: selectedType,
                        targetRideCount: selectedType == .rideCount ? targetRideCount : nil,
                        minAverageSpeed: selectedType == .speed ? minAverageSpeed : nil
                    )

                    challengeManager.availableChallenges.append(newChallenge)
                    dismiss()
                }
                .disabled(name.isEmpty || (goalInKm <= 0 && selectedType != .rideCount && selectedType != .speed))
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Neue Challenge")
        }
    }
}
