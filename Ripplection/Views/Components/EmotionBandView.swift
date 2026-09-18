//
//  EmotionBandView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 17/09/26.
//

import Foundation
import SwiftUI

/// A single intensity band within one Plutchik petal — e.g. "Joy" within the
/// Joy family. Purely visual/accessible; the actual touch routing for the
/// whole petal happens one level up in `EmotionPetalView`, since hit-testing
/// needs to follow the petal's curved outline rather than this rectangle's
/// full bounds.
struct EmotionBandView: View {
    let emotion: Emotion
    let isSelected: Bool
    let isDimmed: Bool
    let onSelect: (Emotion) -> Void

    var body: some View {
        Rectangle()
            .fill(emotion.color)
            .opacity(isDimmed ? 0.22 : 1)
            .overlay {
                if isSelected {
                    Rectangle().stroke(.white, lineWidth: 2)
                }
            }
            .accessibilityElement()
            .accessibilityLabel(emotion.displayName)
            .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : [.isButton])
            .accessibilityAction { onSelect(emotion) }
            .animation(.easeInOut(duration: 0.25), value: isDimmed)
            .animation(.easeInOut(duration: 0.25), value: isSelected)
    }
}
