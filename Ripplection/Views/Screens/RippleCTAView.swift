//
//  RippleCTAView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

/// Fifth step: a deliberate pause before submitting — tapping the orb
/// triggers the ripple haptic and moves to the reflection card.
struct RippleCTAView: View {
    @Bindable var viewModel: CheckInFlowViewModel
//    @State private var rippleLevel: Double = 0.6
    @State private var isRippling = false

    var body: some View {
        VStack(spacing: 48) {
            Text("Let it ripple.")
                .font(.title3.weight(.medium))

            LiquidOrb(level: $viewModel.energyLevel, isInteractive: false, tint: .blue, diameter: 220)
                .scaleEffect(isRippling ? 1.15 : 1.0)
                .overlay {
                    Image(systemName: "drop.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                }
                .onTapGesture {
                    withAnimation(.spring(response: 1.5, dampingFraction: 0.35)) {
                        isRippling = true
                    } completion: {
                        viewModel.submitRipple()
                    }
                }

            Spacer()
        }
        .padding(.top, 100)
    }
}
