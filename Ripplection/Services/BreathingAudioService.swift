//
//  BreathingAudioService.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import AVFoundation
import Foundation

protocol BreathingAudioPlaying {
    func startAmbient()
    func stopAmbient()
    func playPhaseChime()
}

/// Plays a looping ambient bed during Box Breathing, with a short chime
/// layered on top at each phase transition. Ambient-only for now — no other
/// screen plays sound.
final class BreathingAudioService: BreathingAudioPlaying {
    private let engine = AVAudioEngine()
    private let ambientPlayer = AVAudioPlayerNode()
    private let chimePlayer = AVAudioPlayerNode()

    private var ambientBuffer: AVAudioPCMBuffer?
    private var chimeBuffer: AVAudioPCMBuffer?

    init() {
        configureAudioSession()
        attachNodes()
        loadBuffers()
    }

    func startAmbient() {
        guard let ambientBuffer else { return }
        if !engine.isRunning { try? engine.start() }
        ambientPlayer.volume = 0
        ambientPlayer.scheduleBuffer(ambientBuffer, at: nil, options: .loops)
        ambientPlayer.play()
        fade(node: ambientPlayer, to: 0.6, duration: 1.5)
    }

    func stopAmbient() {
        fade(node: ambientPlayer, to: 0, duration: 1.0) { [weak self] in
            self?.ambientPlayer.stop()
        }
    }

    func playPhaseChime() {
        guard let chimeBuffer, engine.isRunning else { return }
        chimePlayer.scheduleBuffer(chimeBuffer, at: nil)
        chimePlayer.play()
    }

    // MARK: - Setup

    private func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.ambient, options: [.mixWithOthers])
        try? session.setActive(true)
    }

    private func attachNodes() {
        engine.attach(ambientPlayer)
        engine.attach(chimePlayer)
        engine.connect(ambientPlayer, to: engine.mainMixerNode, format: nil)
        engine.connect(chimePlayer, to: engine.mainMixerNode, format: nil)
    }

    private func loadBuffers() {
        ambientBuffer = Self.loadBuffer(named: "breathing_ambient", withExtension: "caf")
        chimeBuffer = Self.loadBuffer(named: "breathing_chime", withExtension: "caf")
    }

    private static func loadBuffer(named name: String, withExtension ext: String) -> AVAudioPCMBuffer? {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext),
              let file = try? AVAudioFile(forReading: url) else { return nil }
        let format = file.processingFormat
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(file.length)) else { return nil }
        try? file.read(into: buffer)
        return buffer
    }

    private func fade(node: AVAudioPlayerNode, to targetVolume: Float, duration: TimeInterval, completion: (() -> Void)? = nil) {
        let steps = 30
        let stepDuration = duration / Double(steps)
        let startVolume = node.volume
        let delta = (targetVolume - startVolume) / Float(steps)

        for step in 0...steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + stepDuration * Double(step)) {
                node.volume = startVolume + delta * Float(step)
                if step == steps { completion?() }
            }
        }
    }
}
