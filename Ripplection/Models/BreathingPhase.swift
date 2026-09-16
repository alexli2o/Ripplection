//
//  BreathingPhase.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation

/// One phase of a 4-4-4-4 box breathing cycle.
enum BreathingPhase: CaseIterable, Equatable {
    case inhale, holdAfterInhale, exhale, holdAfterExhale

    var instruction: String {
        switch self {
        case .inhale: return "Inhale for 4 seconds…"
        case .holdAfterInhale: return "Hold…"
        case .exhale: return "Exhale for 4 seconds…"
        case .holdAfterExhale: return "Hold…"
        }
    }

    var duration: TimeInterval { 4 }

    var next: BreathingPhase {
        switch self {
        case .inhale: return .holdAfterInhale
        case .holdAfterInhale: return .exhale
        case .exhale: return .holdAfterExhale
        case .holdAfterExhale: return .inhale
        }
    }
}
