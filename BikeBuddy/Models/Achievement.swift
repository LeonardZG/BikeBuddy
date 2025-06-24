//
//  Achievement.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 24.05.25.
//

import Foundation

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let isUnlocked: Bool
}
