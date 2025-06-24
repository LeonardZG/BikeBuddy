//
//  TipService.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 23.05.25.
//

import Foundation

struct TipService {
    static let tips: [String] = [
        "🚴‍♂️ Fahre regelmäßig, statt selten und extrem!",
        "📱 Nutze deine Fahrten, um neue Orte zu entdecken.",
        "🧠 Radfahren stärkt Konzentration & Wohlbefinden.",
        "🌍 Jeder Kilometer spart CO₂ – weiter so!",
        "🏞 Kurze Fahrten ersetzen Autofahrten – gut für die Umwelt."
    ]

    static func randomTip() -> String {
        tips.randomElement() ?? "Halte dich fit – fahr Rad!"
    }
}
