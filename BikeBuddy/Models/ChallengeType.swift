//
//  ChallengeType.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 22.05.25.
//

import Foundation

enum ChallengeType: String, Codable {
    case weekly
    case monthly
    case oneTime
    case daily
    case distance
    case rideCount
    case speed
}
