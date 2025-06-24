# BikeBuddy

BikeBuddy ist eine iOS-App zur Fahrterfassung und Challenge-Auswertung mit manueller Eingabe und GPS-Tracking. Die App wurde mit SwiftUI nach dem MVVM-Prinzip entwickelt.

## Funktionen
- Manuelle Fahrtenerfassung (Datum, Distanz, Dauer)
- GPS-Tracking mit Live-Karte und Routenauswertung
- Erstellung und Verwaltung von Challenges
- Fortschrittsanzeige in Echtzeit (inkl. Geschwindigkeit, Distanz, etc.)
- Erfolge & Fahrtenhistorie
- Lokale Speicherung aller Daten (UserDefaults, JSON)

## Screenshots
<img src="dashboard.png" width="300"> <img src="tracking.png" width="300">

## Projektstruktur
- `Models/` – Datenmodelle (Ride, Challenge, Achievement)
- `ViewModels/` – Zustandsverwaltung
- `Views/` – UI-Komponenten (z. B. Dashboard, TrackingView)
- `Services/` – z. B. GPS-Tracking, Daten-Storage

## Installation
Projekt kann direkt mit Xcode geöffnet werden (`BikeBuddy.xcodeproj`).

## Lizenz
Privates Hochschulprojekt – nicht für produktiven Einsatz bestimmt.

