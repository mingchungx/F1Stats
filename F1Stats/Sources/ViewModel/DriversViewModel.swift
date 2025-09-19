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
    
    private let driverRepository: DriverRepository
    private var cancellables = Set<AnyCancellable>()
    
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
        Task {
            await driverRepository.getAllDrivers()
        }
    }
}
