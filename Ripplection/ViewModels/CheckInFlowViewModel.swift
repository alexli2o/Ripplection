//
//  CheckInFlowViewModel.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftData
import Observation

/// Drives the linear check-in ritual: breathing → emotion → energy → source
/// → ripple → card. Owns all state collected along the way and commits it to
/// SwiftData when the ritual completes.
@Observable
final class CheckInFlowViewModel {
    private(set) var step: FlowStep = .breathing

    var selectedEmotion: Emotion?
    var energyLevel: Double = 0.5
    var selectedSource: CheckInSource?
    private(set) var reflectionQuote: ReflectionQuote?

    private let quoteProvider: ReflectionQuoteProviding
    private let haptics: HapticsProviding

    init(
        quoteProvider: ReflectionQuoteProviding = MockReflectionQuoteProvider(),
        haptics: HapticsProviding = HapticsService()
    ) {
        self.quoteProvider = quoteProvider
        self.haptics = haptics
    }

    var canAdvanceFromEmotion: Bool { selectedEmotion != nil }
    var canAdvanceFromSource: Bool { selectedSource != nil }

    func selectEmotion(_ emotion: Emotion) {
        selectedEmotion = emotion
        haptics.playEmotionSelection()
    }

    func selectSource(_ source: CheckInSource) {
        selectedSource = source
    }

    func advance() {
        guard let next = step.next else { return }
        if next == .card {
            reflectionQuote = quoteProvider.randomQuote()
        }
        step = next
    }

    func submitRipple() {
        haptics.playRippleSubmit()
        advance()
    }

    /// Persists the completed check-in. Call once, when the ritual finishes.
    func saveEntry(in context: ModelContext) {
        guard let selectedEmotion, let selectedSource, let reflectionQuote else { return }
        let entry = CheckInEntry(
            emotion: selectedEmotion,
            energyLevel: energyLevel,
            source: selectedSource,
            reflectionQuoteText: reflectionQuote.text
        )
        context.insert(entry)
    }
}
