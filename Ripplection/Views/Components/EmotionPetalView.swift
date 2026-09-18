//
//  EmotionPetalView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 17/09/26.
//

import Foundation
import SwiftUI

/// One full Plutchik-style petal for a single emotion family: three
/// `EmotionBandView`s (mild outer, basic middle, intense inner) stacked and
/// clipped to `PetalShape`, then rotated into position on the wheel.
struct EmotionPetalView: View {
    let family: EmotionFamily
    let selected: Emotion?
    let onSelect: (Emotion) -> Void

    var size: CGSize = CGSize(width: 48, height: 140)

    var body: some View {
        VStack(spacing: 0) {
            band(.mild)
            band(.basic)
            band(.intense)
        }
        .frame(width: size.width, height: size.height)
        .clipShape(PetalShape())
        .overlay(PetalShape().stroke(.black.opacity(0.12), lineWidth: 0.75))
        // clipShape only affects rendering, not hit-testing — without this,
        // the invisible rectangular corners of neighboring petals would
        // overlap near the wheel's center and steal each other's taps.
        .contentShape(PetalShape())
        .gesture(tapGesture)
        .offset(y: -size.height / 2)
        .rotationEffect(.degrees(family.angleDegrees))
    }

    private func band(_ intensity: EmotionIntensity) -> some View {
        let emotion = family.emotion(at: intensity)
        return EmotionBandView(
            emotion: emotion,
            isSelected: emotion == selected,
            isDimmed: selected != nil && emotion != selected,
            onSelect: onSelect
        )
    }

    /// One spatial tap over the whole petal, bucketed by vertical position
    /// into mild/basic/intense, rather than three separate per-band
    /// gestures — this is what lets `contentShape` above define a single,
    /// accurate curved hit region for the entire petal.
    private var tapGesture: some Gesture {
        SpatialTapGesture()
            .onEnded { value in
                onSelect(family.emotion(at: intensity(atLocalY: value.location.y)))
            }
    }

    private func intensity(atLocalY y: CGFloat) -> EmotionIntensity {
        switch y / size.height {
        case ..<(1.0 / 3.0): return .mild
        case ..<(2.0 / 3.0): return .basic
        default: return .intense
        }
    }
}
