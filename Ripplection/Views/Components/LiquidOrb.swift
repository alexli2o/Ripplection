//
//  LiquidOrb.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import SwiftUI

/// A glass sphere with an animated liquid fill inside. The fill level can be
/// static and decorative (Home, CTA) or interactively set by a vertical drag
/// (Physical Energy), depending on `isInteractive`.
struct LiquidOrb: View {
    @Binding var level: Double
    var isInteractive: Bool = false
    var tint: Color = .blue
    var diameter: CGFloat = 220
    var onDragEnded: (() -> Void)? = nil

    @State private var isDragging = false
    @State private var dragStartLevel: Double = 0

    var body: some View {
        TimelineView(.animation) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            let wavePhase = t.truncatingRemainder(dividingBy: 3) / 3 * 2 * .pi

            ZStack {
                Circle()
                    .fill(.white.opacity(0.15))

                LiquidWaveShape(level: level, phase: wavePhase)
                    .fill(
                        LinearGradient(
                            colors: [tint.opacity(0.85), tint.opacity(0.45)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .clipShape(Circle())

                Color.clear
                    .glassEffect(.regular, in: Circle())
            }
        }
        .frame(width: diameter, height: diameter)
        .contentShape(Circle())
        .gesture(dragGesture)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Energy level")
        .accessibilityValue("\(Int(level * 100)) percent")
        .accessibilityAdjustableAction { direction in
            guard isInteractive else { return }
            switch direction {
            case .increment: level = (level + 0.05).clamped(to: 0...1)
            case .decrement: level = (level - 0.05).clamped(to: 0...1)
            default: break
            }
        }
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                guard isInteractive else { return }
                if !isDragging {
                    isDragging = true
                    dragStartLevel = level
                }
                let delta = -value.translation.height / diameter
                level = (dragStartLevel + delta).clamped(to: 0...1)
            }
            .onEnded { _ in
                guard isInteractive else { return }
                isDragging = false
                onDragEnded?()
            }
    }
}

#Preview {
    @Previewable @State var level: Double = 0.5
    return LiquidOrb(level: $level, isInteractive: true)
}
