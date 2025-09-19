import SwiftUI

@main
struct F1StatsApp: App {
    @StateObject private var driverRepository: DriverRepository
    
    init() {
        lazy var driverRepository: DriverRepository = .init()
        self._driverRepository = .init(wrappedValue: driverRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(driverRepository)
        }
    }
}
