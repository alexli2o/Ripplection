//
//  EmotionInstensity.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 17/09/26.
//

import Foundation

/// How intensely a `Emotion` is felt, mapping to Plutchik's three concentric
/// rings — `.mild` is the outer, palest ring; `.intense` is the innermost,
/// most saturated ring closest to the center of the wheel.
enum EmotionIntensity: Int, CaseIterable, Comparable {
    case mild, basic, intense

    static func < (lhs: EmotionIntensity, rhs: EmotionIntensity) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
