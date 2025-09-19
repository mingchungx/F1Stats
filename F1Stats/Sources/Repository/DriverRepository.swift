//
//  DriverRepository.swift
//  F1Stats
//
//  Created by Mingchung Xia on 2025-09-19.
//

import Foundation
import Combine

@MainActor
final class DriverRepository: ObservableObject {
    @Published private(set) var drivers: [Driver] = []
    
    private let driverService: DriverService = .shared
    private let _name: String = "DriverRepository"
    
    init() {
        Task {
            await getAllDrivers()
        }
    }
}

extension DriverRepository {
    func getAllDrivers() async {
        debugPrint("\(_name): getAllDrivers called")
        self.drivers = await driverService.fetchAllDrivers()
    }
}
