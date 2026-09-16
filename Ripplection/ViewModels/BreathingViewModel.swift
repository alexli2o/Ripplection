//
//  BreathingViewModel.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import Observation

/// Drives a single 4-4-4-4 box breathing cycle: timing, phase transitions,
/// and the haptic/audio cues tied to each transition.
@Observable
final class BreathingViewModel {
    private(set) var phase: BreathingPhase = .inhale
    private(set) var secondsRemaining: Int = Int(BreathingPhase.inhale.duration)
    private(set) var cyclesCompleted: Int = 0

    let totalCycles: Int

    private var timer: Timer?
    private let haptics: HapticsProviding
    private let audio: BreathingAudioPlaying

    init(
        totalCycles: Int = 1,
        haptics: HapticsProviding = HapticsService(),
        audio: BreathingAudioPlaying = BreathingAudioService()
    ) {
        self.totalCycles = totalCycles
        self.haptics = haptics
        self.audio = audio
    }

    var isFinished: Bool { cyclesCompleted >= totalCycles }

    /// Progress of the current phase, 0...1 — used to animate the breathing cube's fill.
    var phaseProgress: Double {
        1 - (Double(secondsRemaining) / phase.duration)
    }

    func start() {
        audio.startAmbient()
        beginPhase(.inhale)
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        audio.stopAmbient()
    }

    private func beginPhase(_ newPhase: BreathingPhase) {
        phase = newPhase
        secondsRemaining = Int(newPhase.duration)
        haptics.playBreathingPhaseChange(to: newPhase)
        audio.playPhaseChime()

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    private func tick() {
        guard secondsRemaining > 1 else {
            advancePhase()
            return
        }
        secondsRemaining -= 1
    }

    private func advancePhase() {
        if phase == .holdAfterExhale {
            cyclesCompleted += 1
        }
        guard !isFinished else {
            stop()
            return
        }
        beginPhase(phase.next)
    }
}
