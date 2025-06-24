//
//  LocationManager.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 23.05.25.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var manager = CLLocationManager()

    @Published var location: CLLocation?
    @Published var isAuthorized = false
    @Published var isTracking = false
    @Published var isPaused = false
    @Published var trackedLocations: [CLLocation] = []

    @Published var startTime: Date?
    @Published var elapsedTime: TimeInterval = 0

    private var timer: Timer?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        location = newLocation

        if isTracking && !isPaused {
            trackedLocations.append(newLocation)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            manager.startUpdatingLocation()
        default:
            isAuthorized = false
        }
    }
    
    func startTracking() {
        trackedLocations = []
        startTime = Date()
        elapsedTime = 0
        isTracking = true
        isPaused = false

        startTimer()
    }
    
    func pauseTracking() {
        isPaused = true
        stopTimer()
    }

    func resumeTracking() {
        isPaused = false
        startTimer()
    }

    func stopTracking() {
        isTracking = false
        isPaused = false
        stopTimer()
        startTime = nil
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let start = self.startTime {
                self.elapsedTime = Date().timeIntervalSince(start)
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    var totalDistance: Double {
        guard trackedLocations.count > 1 else { return 0 }
        var distance: Double = 0
        for i in 1..<trackedLocations.count {
            distance += trackedLocations[i].distance(from: trackedLocations[i - 1])
        }
        return distance / 1000 // in km
    }
}
