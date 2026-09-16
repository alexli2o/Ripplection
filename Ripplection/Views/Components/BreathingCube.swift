//
//  BreathingCube.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

/// The glassy square used during Box Breathing. Its fill rises and falls with
/// the current phase's progress, and it displays the seconds remaining.
struct BreathingCubeView: View {
    let phase: BreathingPhase
    let progress: Double // 0...1 within the current phase
    let secondsRemaining: Int
    var size: CGFloat = 220

    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 36)
//                .fill(.white.opacity(0.12))

            RoundedRectangle(cornerRadius: 36)
                .fill(
                    LinearGradient(colors: [.blue.opacity(0.8), .blue.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                )
                .mask(alignment: .bottom) {
                    Rectangle()
                        .frame(height: size * CGFloat(fillFraction))
                }

            Color.clear
                .glassEffect(.regular, in: .rect(cornerRadius: 36))

            Text("\(secondsRemaining)")
                .font(.system(size: 64, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)
                .contentTransition(.numericText(countsDown: true))
        }
        .frame(width: size, height: size)
        .animation(.easeInOut(duration: 1), value: secondsRemaining)
    }

    /// Inhale/hold-after-inhale fill upward; exhale/hold-after-exhale fill downward.
    private var fillFraction: Double {
        switch phase {
        case .inhale: return progress
        case .holdAfterInhale: return 1
        case .exhale: return 1 - progress
        case .holdAfterExhale: return 0
        }
    }
}

#Preview {
    BreathingCubeView(phase: .inhale, progress: 0.5, secondsRemaining: 2)
}
