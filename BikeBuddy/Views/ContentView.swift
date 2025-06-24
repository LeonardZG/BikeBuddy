//
//  ContentView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 21.05.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ChallengeListView()
                .tabItem {
                    Label("Challenges", systemImage: "flag")
                }

            GPSTrackingView()
                .tabItem {
                    Label("Tracking", systemImage: "location.circle")
                }

            AddRideView()
                .tabItem {
                    Label("Ride", systemImage: "plus.circle")
                }

            ProfilView()
                .tabItem {
                    Label("Profil", systemImage: "person.crop.circle")
                }
        }
    }
}
