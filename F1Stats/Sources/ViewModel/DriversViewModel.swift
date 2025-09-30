//
//  DriversViewModel.swift
//  F1Stats
//
//  Created by Mingchung Xia on 2025-09-19.
//

import Foundation
import Combine

@MainActor
final class DriversViewModel: ObservableObject {
    @Published private(set) var drivers: [Driver]
    
    private let _name: String = "DriversViewModel"
    private let driverRepository: DriverRepository
    private var cancellables = Set<AnyCancellable>()
    private var getAllDriversTask: Task<Void, Never>?
    private var getAllDriversTaskId: UUID?
    
    init(driverRepository: DriverRepository) {
        self.driverRepository = driverRepository
        self._drivers = .init(initialValue: driverRepository.drivers)
        
        self.driverRepository.$drivers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self else { return }
                self.drivers = newValue
            }
            .store(in: &cancellables)
    }
}

extension DriversViewModel {
    func refresh() {
        getAllDriversTask?.cancel()
        getAllDriversTaskId = UUID()
        let currentTaskId = getAllDriversTaskId
        getAllDriversTask = Task { [weak self] in
            guard let self else { return }
            do {
                let result = await self.driverRepository.getAllDrivers()
                try Task.checkCancellation()
                guard currentTaskId == self.getAllDriversTaskId else { return }
                self.drivers = result
            } catch is CancellationError {
                // Do nothing
            } catch let error {
                debugPrint("\(_name): \(String(describing: error))")
            }
        }
    }
}
