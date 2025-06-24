//
//  DashboardView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 21.05.25.
//
import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var challengeManager: ChallengeManager
    @EnvironmentObject var rideManager: RideManager
    let tipOfTheWeek = TipService.randomTip()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.green.opacity(0.05)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        TipOfTheWeekView(tip: tipOfTheWeek)
                        OverviewBox(totalDistance: rideManager.totalDistance, totalDuration: totalDurationInHours())

                        Text("🏁 Aktive Challenges")
                            .font(.title2)
                            .bold()

                        if challengeManager.activeChallenges.isEmpty {
                            Text("Du hast momentan keine aktive Challenge.")
                                .foregroundColor(.gray)
                                .italic()
                        } else {
                            ForEach(sortedChallenges) { challenge in
                                ChallengeBoxDashboard(challenge: challenge)
                            }
                        }

                        Spacer()
                    }
                    .padding()
                }
                .navigationTitle("Dashboard")
                .onAppear {
                    challengeManager.removeExpiredChallenges(with: rideManager.rides)
                }
            }
        }
    }

    private func totalDurationInHours() -> String {
        let totalMinutes = rideManager.rides.reduce(0) { $0 + $1.durationInMinutes }
        let hours = totalMinutes / 60
        return String(format: "%.1f", hours)
    }

    private var sortedChallenges: [Challenge] {
        challengeManager.activeChallenges.sorted {
            let a = challengeManager.isChallengeFulfilled($0, with: rideManager.rides)
            let b = challengeManager.isChallengeFulfilled($1, with: rideManager.rides)
            return a == b ? false : !a
        }
    }
}
