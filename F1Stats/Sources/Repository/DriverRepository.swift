//
//  DriverRepository.swift
//  F1Stats
//
//  Created by Mingchung Xia on 2025-09-19.
//

import Foundation
import Combine

final class DriverRepository: ObservableObject {
    @Published private(set) var drivers: [Driver] = []
    
    private let driverService: DriverService = .shared
    private let _name: String = "DriverRepository"
    private var hydrationTask: Task<Void, Never>?
    
    init() {
        hydrationTask?.cancel()
        hydrationTask = Task.detached(priority: .background) { [weak self] in
            guard let self else { return }
            if !Task.isCancelled {
                await self.getAllDrivers()
            }
        }
    }
}

extension DriverRepository {
    @concurrent @discardableResult
    func getAllDrivers() async -> [Driver] {
        debugPrint("\(_name): getAllDrivers called")
        if !drivers.isEmpty { return drivers }
        let drivers = await driverService.fetchAllDrivers()
        await MainActor.run {
            self.drivers = drivers
        }
        return drivers
    }
}
