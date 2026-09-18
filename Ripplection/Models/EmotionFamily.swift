//
//  EmotionFamily.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 17/09/26.
//

import Foundation
import SwiftUI

/// One of Plutchik's 8 primary emotion families, arranged clockwise around
/// the wheel starting straight up. Each family spans 3 intensities (see
/// `EmotionIntensity`) built from one base hue.
enum EmotionFamily: Int, CaseIterable, Identifiable {
    case joy, trust, fear, surprise, sadness, disgust, anger, anticipation

    var id: Int { rawValue }

    /// Clockwise placement around the wheel — Joy sits at the top (0°).
    var angleDegrees: Double { Double(rawValue) * 45 }

    /// Base hue, chosen so hues rotate smoothly around the wheel the same
    /// way Plutchik's original color wheel does (red → orange → yellow →
    /// green → teal → blue → purple → back to red).
    private var hue: Double {
        switch self {
        case .joy: return 0.15
        case .trust: return 0.33
        case .fear: return 0.42
        case .surprise: return 0.55
        case .sadness: return 0.62
        case .disgust: return 0.80
        case .anger: return 0.0
        case .anticipation: return 0.08
        }
    }

    /// Palest at `.mild`, most saturated and darkest at `.intense`.
    func color(at intensity: EmotionIntensity) -> Color {
        switch intensity {
        case .mild: return Color(hue: hue, saturation: 0.35, brightness: 0.97)
        case .basic: return Color(hue: hue, saturation: 0.65, brightness: 0.88)
        case .intense: return Color(hue: hue, saturation: 0.85, brightness: 0.65)
        }
    }

    func emotion(at intensity: EmotionIntensity) -> Emotion {
        switch (self, intensity) {
        case (.joy, .mild): return .serenity
        case (.joy, .basic): return .joy
        case (.joy, .intense): return .ecstasy
        case (.trust, .mild): return .acceptance
        case (.trust, .basic): return .trust
        case (.trust, .intense): return .admiration
        case (.fear, .mild): return .apprehension
        case (.fear, .basic): return .fear
        case (.fear, .intense): return .terror
        case (.surprise, .mild): return .distraction
        case (.surprise, .basic): return .surprise
        case (.surprise, .intense): return .amazement
        case (.sadness, .mild): return .pensiveness
        case (.sadness, .basic): return .sadness
        case (.sadness, .intense): return .grief
        case (.disgust, .mild): return .boredom
        case (.disgust, .basic): return .disgust
        case (.disgust, .intense): return .loathing
        case (.anger, .mild): return .annoyance
        case (.anger, .basic): return .anger
        case (.anger, .intense): return .rage
        case (.anticipation, .mild): return .interest
        case (.anticipation, .basic): return .anticipation
        case (.anticipation, .intense): return .vigilance
        }
    }
}
