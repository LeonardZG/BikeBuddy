//
//  AppSettingsView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 21.05.25.
//

import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var rideManager: RideManager
    @EnvironmentObject var challengeManager: ChallengeManager
    @EnvironmentObject var achievementManager: AchievementManager

    @State private var showResetConfirmation = false
    @State private var resetType: ResetAction? = nil

    enum ResetAction: String, CaseIterable {
        case rides, challenges, achievements

        var label: String {
            switch self {
            case .rides: return "Alle Fahrten löschen"
            case .challenges: return "Challenges zurücksetzen"
            case .achievements: return "Erfolge zurücksetzen"
            }
        }

        var systemImage: String {
            switch self {
            case .rides: return "trash"
            case .challenges: return "flag.slash"
            case .achievements: return "rosette"
            }
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("App")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundColor(.secondary)
                    }
                }

                Section(header: Text("Datenverwaltung")) {
                    ForEach(ResetAction.allCases, id: \.self) { action in
                        Button(role: .destructive) {
                            resetType = action
                            showResetConfirmation = true
                        } label: {
                            Label(action.label, systemImage: action.systemImage)
                        }
                    }
                }

                Section(header: Text("Hinweis")) {
                    Text("Diese App speichert alle Daten lokal auf deinem Gerät. Es findet keine Übertragung an Dritte statt.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Einstellungen")
            .confirmationDialog("Daten wirklich löschen?", isPresented: $showResetConfirmation, titleVisibility: .visible) {
                Button("Löschen", role: .destructive) {
                    performReset()
                }
                Button("Abbrechen", role: .cancel) { }
            } message: {
                if let type = resetType {
                    Text("Bist du sicher, dass du '\(type.label)' löschen möchtest?")
                }
            }
        }
    }

    private func performReset() {
        switch resetType {
        case .rides:
            rideManager.rides = []
            rideManager.saveRides()
        case .challenges:
            challengeManager.activeChallenges = []
            challengeManager.availableChallenges = []
        case .achievements:
            achievementManager.achievements = []
        case .none:
            break
        }
    }
}
