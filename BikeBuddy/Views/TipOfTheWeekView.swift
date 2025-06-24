//
//  TipOfTheWeekView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 25.05.25.
//

import SwiftUI

struct TipOfTheWeekView: View {
    let tip: String

    var body: some View {
        GroupBox(label: Label("Tipp der Woche", systemImage: "lightbulb")) {
            Text(tip)
                .font(.subheadline)
                .padding(.vertical, 4)
        }
    }
}
