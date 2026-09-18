////
////  EmotionFlowerView.swift
////  Ripplection
////
////  Created by Alexander Yofilio S on 15/09/26.
////
//
//import SwiftUI
//
///// The emotion picker: one petal per `Emotion`, arranged radially. Tapping a
///// petal selects it and reports the choice via `onSelect`.
//struct EmotionFlowerView: View {
//    let selected: Emotion?
//    let onSelect: (Emotion) -> Void
//
//    private let emotions = Emotion.allCases
//    private let petalSize = CGSize(width: 46, height: 120)
//
//    var body: some View {
//        ZStack {
//            ForEach(emotions) { emotion in
//                petal(for: emotion)
//            }
//
//            Color.clear
//                .frame(width: 46, height: 46)
//                .glassEffect(.regular, in: Circle())
//        }
//        .frame(width: 260, height: 260)
//    }
//
//    private func petal(for emotion: Emotion) -> some View {
//        let index = emotions.firstIndex(of: emotion) ?? 0
//        let angle = Angle(degrees: Double(index) / Double(emotions.count) * 360)
//        let isSelected = emotion == selected
//
//        return PetalShape()
//            .fill(emotion.color.opacity(isSelected ? 1 : 0.6))
//            .frame(width: petalSize.width, height: petalSize.height)
//            .scaleEffect(isSelected ? 1.08 : 1.0)
//            .offset(y: -petalSize.height / 2)
//            .rotationEffect(angle)
//            .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isSelected)
//            .onTapGesture { onSelect(emotion) }
//            .accessibilityLabel(emotion.displayName)
//            .accessibilityAddTraits(isSelected ? [.isSelected] : [])
//    }
//}
//
//#Preview {
//    EmotionFlowerView(selected: .calm) { _ in }
//}

import SwiftUI

/// The emotion picker: a Plutchik-style wheel of 8 petals, each split into
/// three tappable intensity bands (24 emotions total, matching Plutchik's
/// wheel minus its outermost dyad ring). Tapping any band selects that
/// specific emotion, lighting it up while dimming every other emotion on
/// the wheel, regardless of family.
struct EmotionFlowerView: View {
    let selected: Emotion?
    let onSelect: (Emotion) -> Void

    private let diameter: CGFloat = 300

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                ForEach(EmotionFamily.allCases) { family in
                    EmotionPetalView(family: family, selected: selected, onSelect: onSelect)
                }

//                Color.clear
//                    .frame(width: 48, height: 48)
//                    .glassEffect(.regular, in: Circle())
            }
            .frame(width: diameter, height: diameter)
            
            if let selected {
                Text(selected.displayName)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.primary)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: selected)
    }
}

#Preview {
    EmotionFlowerView(selected: .ecstasy) { _ in }
}
