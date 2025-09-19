//
//  DriverModel.swift
//  F1Stats
//
//  Created by Mingchung Xia on 2025-09-19.
//

import Foundation
import SwiftUI

struct Driver: Identifiable, Codable {
    var id: Int { driverNumber }
    
    let countryCode: String?
    let driverNumber: Int
    let firstName: String
    let fullName: String
    let headshotUrl: String?
    let lastName: String
    let nameAcronym: String
    let teamColour: String
    let teamName: String
}

extension Driver {
    var color: Color {
        Color(hex: teamColour)
    }
    
    var headshot: URL? {
        guard let headshotUrl else { return nil }
        return URL(string: headshotUrl)
    }
}
