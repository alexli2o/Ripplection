//
//  Emotion.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

/// A single emotional state a person can select during a check-in.
/// Conforms to `Codable` so it can be stored directly as a SwiftData attribute.
enum Emotion: String, CaseIterable, Identifiable, Codable, Hashable {
    case joy, calm, gratitude, sadness, anger, anxiety, tiredness

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .joy: return "Joy"
        case .calm: return "Calm"
        case .gratitude: return "Gratitude"
        case .sadness: return "Sadness"
        case .anger: return "Anger"
        case .anxiety: return "Anxiety"
        case .tiredness: return "Tiredness"
        }
    }

    /// Petal color used by `EmotionFlowerView`.
    var color: Color {
        switch self {
        case .joy: return .yellow
        case .calm: return .mint
        case .gratitude: return .pink
        case .sadness: return .blue
        case .anger: return .red
        case .anxiety: return .purple
        case .tiredness: return .gray
        }
    }
}
