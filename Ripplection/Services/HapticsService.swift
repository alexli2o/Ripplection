//
//  HapticsService.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import CoreHaptics
import Foundation

protocol HapticsProviding {
    func playBreathingPhaseChange(to phase: BreathingPhase)
    func playEmotionSelection()
    func playRippleSubmit()
}

/// Plays short, intentional haptic feedback for the app's three meaningful
/// moments: breathing phase changes, emotion selection, and check-in
/// submission. Deliberately does NOT wrap every tap — haptics here reinforce
/// meaning, not decoration.
final class HapticsService: HapticsProviding {
    private var engine: CHHapticEngine?
    private let supportsHaptics = CHHapticEngine.capabilitiesForHardware().supportsHaptics

    init() {
        guard supportsHaptics else { return }
        engine = try? CHHapticEngine()
        engine?.resetHandler = { [weak self] in try? self?.engine?.start() }
        try? engine?.start()
    }

    func playBreathingPhaseChange(to phase: BreathingPhase) {
        switch phase {
        case .inhale:
            playIntensityRamp(from: 0.15, to: 0.85, duration: phase.duration)
        case .exhale:
            playIntensityRamp(from: 0.85, to: 0.15, duration: phase.duration)
        case .holdAfterInhale, .holdAfterExhale:
            playSustainedPulse(duration: 0.5)
        }
    }

    func playEmotionSelection() {
        playTransient(intensity: 0.7, sharpness: 0.9)
    }

    func playRippleSubmit() {
        playTransient(intensity: 0.9, sharpness: 0.7, at: 0)
        playTransient(intensity: 0.5, sharpness: 0.4, at: 0.12)
        playTransient(intensity: 0.3, sharpness: 0.3, at: 0.24)
    }

    // MARK: - Private pattern builders

    private func playTransient(intensity: Float, sharpness: Float, at time: TimeInterval = 0) {
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
            ],
            relativeTime: time
        )
        play(events: [event], curves: [])
    }

    private func playSustainedPulse(duration: TimeInterval) {
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ],
            relativeTime: 0,
            duration: duration
        )
        play(events: [event], curves: [])
    }

    private func playIntensityRamp(from start: Float, to end: Float, duration: TimeInterval) {
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: start),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ],
            relativeTime: 0,
            duration: duration
        )
        let curve = CHHapticParameterCurve(
            parameterID: .hapticIntensityControl,
            controlPoints: [
                .init(relativeTime: 0, value: start),
                .init(relativeTime: duration, value: end)
            ],
            relativeTime: 0
        )
        play(events: [event], curves: [curve])
    }

    private func play(events: [CHHapticEvent], curves: [CHHapticParameterCurve]) {
        guard supportsHaptics, let engine else { return }
        do {
            let pattern = try CHHapticPattern(events: events, parameterCurves: curves)
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            // Haptics are an enhancement only — never block the experience on failure.
        }
    }
}
