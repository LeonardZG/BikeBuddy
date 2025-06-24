//
//  GPSTrackingView.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 21.05.25.
//

import SwiftUI
import MapKit

struct GPSTrackingView: View {
    @StateObject private var locationManager = LocationManager()

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.0, longitude: 8.0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var showSummary = false
    
    @EnvironmentObject var rideManager: RideManager
    @EnvironmentObject var challengeManager: ChallengeManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                // ⏱ Zeit & Distanz
                HStack {
                    VStack(alignment: .leading) {
                        Text("Dauer")
                            .font(.caption)
                        Text(timeString(from: locationManager.elapsedTime))
                            .font(.title2)
                            .bold()
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Distanz")
                            .font(.caption)
                        Text("\(String(format: "%.2f", locationManager.totalDistance)) km")
                            .font(.title2)
                            .bold()
                    }
                }
                .padding(.horizontal)

                // 🗺️ Karte mit Route
                MapViewWithRoute(
                    region: $region,
                    userLocation: locationManager.location?.coordinate,
                    route: locationManager.trackedLocations.map { $0.coordinate }
                )
                .frame(height: 400)
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()

                // 🔘 Steuerung
                if locationManager.isTracking {
                    HStack(spacing: 20) {
                        Button(locationManager.isPaused ? "Fortsetzen" : "Pausieren") {
                            locationManager.isPaused
                                ? locationManager.resumeTracking()
                                : locationManager.pauseTracking()
                        }
                        .buttonStyle(.bordered)

                        Button("Stoppen") {
                            locationManager.stopTracking()
                            showSummary = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                } else {
                    Button("Tracking starten") {
                        locationManager.startTracking()
                        if let loc = locationManager.location {
                            region.center = loc.coordinate
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }

                Spacer()
            }
            .navigationTitle("GPS-Tracking")
            .onAppear {
                if let loc = locationManager.location {
                    region.center = loc.coordinate
                }
            }
            // ⬇️ Navigation zur Zusammenfassung nach Stopp
            .navigationDestination(isPresented: $showSummary) {
                RideSummaryView(
                    distance: locationManager.totalDistance,
                    duration: locationManager.elapsedTime,
                    date: Date()
                )
                .environmentObject(rideManager)
                .environmentObject(challengeManager)
            }
        }
    }

    private func timeString(from interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
