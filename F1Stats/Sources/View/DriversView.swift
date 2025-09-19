//
//  DriversView.swift
//  F1Stats
//
//  Created by Mingchung Xia on 2025-09-19.
//

import Foundation
import SwiftUI

struct DriversView: View {
    @EnvironmentObject private var driverRepository: DriverRepository
    
    var body: some View {
        DriversViewImpl(
            driverRepository: driverRepository
        )
    }
}

fileprivate struct DriversViewImpl: View {
    @StateObject private var viewModel: DriversViewModel
    
    init(driverRepository: DriverRepository) {
        self._viewModel = .init(wrappedValue: .init(driverRepository: driverRepository))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.drivers) { driver in
                driverItem(driver: driver)
                    .id(driver.id)
            }
        }
        .animation(.default, value: viewModel.drivers.count)
        .refreshable { viewModel.refresh() }
    }
}

fileprivate extension DriversViewImpl {
    @ViewBuilder
    func driverItem(driver: Driver) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(driver.fullName)
                    .fontWeight(.semibold)
                HStack(spacing: 4) {
                    Text(driver.teamName)
                        .font(.caption)
                        .fontWeight(.light)
                    Text("#\(driver.driverNumber)")
                        .font(.caption)
                        .fontWeight(.light)
                }
                .foregroundStyle(driver.color)
            }
            Spacer()
            Text(driver.nameAcronym)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(driver.color)
            if let headshot = driver.headshot {
                AsyncImage(url: headshot) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}

