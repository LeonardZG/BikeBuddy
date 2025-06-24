//
//  ChallengeListView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 21.05.25.
//

import SwiftUI

struct ChallengeListView: View {
    @EnvironmentObject var challengeManager: ChallengeManager

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(challengeManager.availableChallenges) { challenge in
                        let isAlreadyActive = challengeManager.activeChallenges.contains { $0.id == challenge.id }

                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(challenge.name)
                                    .font(.headline)
                                    .foregroundColor(isAlreadyActive ? .gray : .primary)

                                Spacer()

                                // 🗑️ Löschen
                                Button {
                                    challengeManager.removeAvailableChallenge(challenge)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }

                            Text("Ziel: \(Int(challenge.goalInKm)) km")
                                .font(.subheadline)
                                .foregroundColor(isAlreadyActive ? .gray : .primary)

                            Text("Zeitraum: \(formattedDate(challenge.startDate)) – \(formattedDate(challenge.endDate))")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            if isAlreadyActive {
                                Text("✓ Challenge aktiv")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            } else {
                                Button("Challenge starten") {
                                    challengeManager.activateChallenge(challenge)
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .padding(.top, 4)
                            }
                        }
                        .padding()
                        .background(isAlreadyActive ? Color.gray.opacity(0.1) : Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 1)
                    }
                }
                .padding()
            }
            .navigationTitle("Verfügbare Challenges")
            .toolbar {
                NavigationLink(destination: AddChallengeView()) {
                    Image(systemName: "plus")
                }
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
