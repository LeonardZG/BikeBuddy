//
//  SettingsView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 21.05.25.
//

import SwiftUI

struct ProfilView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Profil")) {
                    NavigationLink("Erfolge", destination: AchievementView())
                    NavigationLink("Einstellungen", destination: AppSettingsView())
                    NavigationLink("Fahrtenübersicht", destination: RideHistoryView())
                }
            }
            .navigationTitle("Profil")
        }
    }
}
