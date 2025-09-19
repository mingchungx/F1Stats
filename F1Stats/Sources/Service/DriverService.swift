//
//  DriverService.swift
//  F1Stats
//
//  Created by Mingchung Xia on 2025-09-19.
//

import Foundation
import Combine

final class DriverService {
    // Singleton
    static let shared: DriverService = .init()
    
    private let _name: String = "DriverService"
    
    init() {}
}

extension DriverService {
    func fetchAllDrivers(session: String = "latest") async -> [Driver] {
        var components: URLComponents = .init(string: Environment.baseUrl + "drivers")!
        components.queryItems = [.init(name: "session_key", value: session)]
        
        guard let url = components.url else { return [] }
        
        debugPrint(url)
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            debugPrint("data: \(data), response: \(response)")
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                debugPrint("\(_name): unexpected http response code \(httpResponse.statusCode)")
                return []
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let drivers: [Driver] = try decoder.decode([Driver].self, from: data)
            return drivers
        } catch let error {
            debugPrint("\(_name): unexpected error in fetchAllDrivers: \(error.localizedDescription)")
            return []
        }
    }
}
