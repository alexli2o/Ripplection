//
//  HomeView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI
import SwiftData

/// The app's landing screen: an inviting orb and the entry point into a new check-in.
struct HomeView: View {
    @State private var isPresentingFlow = false
    @State private var homeOrbLevel: Double = 0.5

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            VStack(spacing: 8) {
                Text("A calmer mind,")
                Text("from within you.")
            }
            .font(.title2.weight(.medium))
            .multilineTextAlignment(.center)

            LiquidOrb(level: $homeOrbLevel, isInteractive: false, tint: .blue, diameter: 220)
                .overlay {
                    Button("Start rippling") {
                        isPresentingFlow = true
                    }
                    .buttonStyle(.glass)
                }

            Spacer()
            Spacer()
        }
        .padding(.horizontal, 32)
        .fullScreenCover(isPresented: $isPresentingFlow) {
            CheckInFlowView()
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: CheckInEntry.self, inMemory: true)
}
