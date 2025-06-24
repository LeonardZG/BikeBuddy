//
//  OverviewBox.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 25.05.25.
//

import SwiftUI

struct OverviewBox: View {
    let totalDistance: Double
    let totalDuration: String

    var body: some View {
        GroupBox(label: Label("Übersicht aller Aktivitäten", systemImage: "chart.bar")) {
            HStack(spacing: 32) {
                VStack(alignment: .leading) {
                    Label("Gesamtstrecke", systemImage: "bicycle")
                        .font(.caption)
                    Text("\(String(format: "%.1f", totalDistance)) km")
                        .font(.title3)
                        .bold()
                }

                VStack(alignment: .leading) {
                    Label("Gesamtzeit", systemImage: "clock")
                        .font(.caption)
                    Text("\(totalDuration) Std")
                        .font(.title3)
                        .bold()
                }
            }
            .padding(.top, 4)
        }
    }
}
