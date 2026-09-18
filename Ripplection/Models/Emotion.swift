////
////  Emotion.swift
////  Ripplection
////
////  Created by Alexander Yofilio S on 15/09/26.
////
//
//import Foundation
//import SwiftUI
//
///// A single emotional state a person can select during a check-in.
///// Conforms to `Codable` so it can be stored directly as a SwiftData attribute.
//enum Emotion: String, CaseIterable, Identifiable, Codable, Hashable {
//    case joy, calm, gratitude, sadness, anger, anxiety, tiredness
//
//    var id: String { rawValue }
//
//    var displayName: String {
//        switch self {
//        case .joy: return "Joy"
//        case .calm: return "Calm"
//        case .gratitude: return "Gratitude"
//        case .sadness: return "Sadness"
//        case .anger: return "Anger"
//        case .anxiety: return "Anxiety"
//        case .tiredness: return "Tiredness"
//        }
//    }
//
//    /// Petal color used by `EmotionFlowerView`.
//    var color: Color {
//        switch self {
//        case .joy: return .yellow
//        case .calm: return .mint
//        case .gratitude: return .pink
//        case .sadness: return .blue
//        case .anger: return .red
//        case .anxiety: return .purple
//        case .tiredness: return .gray
//        }
//    }
//}
import SwiftUI

/// A single emotional state a person can select during a check-in, matching
/// one of the 24 labeled regions on Plutchik's wheel of emotions (8 families
/// × 3 intensities). Conforms to `Codable` so it can be stored directly as a
/// SwiftData attribute.
enum Emotion: String, CaseIterable, Identifiable, Codable, Hashable {
    case serenity, joy, ecstasy
    case acceptance, trust, admiration
    case apprehension, fear, terror
    case distraction, surprise, amazement
    case pensiveness, sadness, grief
    case boredom, disgust, loathing
    case annoyance, anger, rage
    case interest, anticipation, vigilance

    var id: String { rawValue }
    var displayName: String { rawValue.capitalized }

    var family: EmotionFamily {
        switch self {
        case .serenity, .joy, .ecstasy: return .joy
        case .acceptance, .trust, .admiration: return .trust
        case .apprehension, .fear, .terror: return .fear
        case .distraction, .surprise, .amazement: return .surprise
        case .pensiveness, .sadness, .grief: return .sadness
        case .boredom, .disgust, .loathing: return .disgust
        case .annoyance, .anger, .rage: return .anger
        case .interest, .anticipation, .vigilance: return .anticipation
        }
    }

    var intensity: EmotionIntensity {
        switch self {
        case .serenity, .acceptance, .apprehension, .distraction,
             .pensiveness, .boredom, .annoyance, .interest:
            return .mild
        case .joy, .trust, .fear, .surprise, .sadness, .disgust, .anger, .anticipation:
            return .basic
        case .ecstasy, .admiration, .terror, .amazement, .grief, .loathing, .rage, .vigilance:
            return .intense
        }
    }

    /// Derived from this emotion's family hue and intensity — matches
    /// Plutchik's color wheel, darker and more saturated toward the center.
    var color: Color { family.color(at: intensity) }
}
