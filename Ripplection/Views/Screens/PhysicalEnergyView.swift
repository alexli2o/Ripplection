//
//  PhysicalEnergyView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

/// Third step: how energized the user feels — set by dragging the liquid
/// orb, mirrored in a battery-style track for clarity and accessibility.
struct PhysicalEnergyView: View {
    @Bindable var viewModel: CheckInFlowViewModel

    var body: some View {
        VStack(spacing: 40) {
            Text("How energized do you feel?")
                .font(.title3.weight(.medium))

            LiquidOrb(level: $viewModel.energyLevel, isInteractive: true, tint: .blue, diameter: 240)

            HStack {
                Image(systemName: "battery.0")
                Slider(value: $viewModel.energyLevel)
                    .tint(.blue)
                Image(systemName: "battery.100")
            }
            .foregroundStyle(.secondary)

            HStack {
                Text("Drained")
                Spacer()
                Text("Energized")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            Spacer()

            Button("Continue") { viewModel.advance() }
                .buttonStyle(.glass)
        }
        .padding(.top, 80)
        .padding(.bottom, 40)
        .padding(.horizontal, 32)
    }
}
