//
//  CheckInEntry.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftData

/// A single saved check-in, persisted locally with SwiftData.
@Model
final class CheckInEntry {
    var date: Date
    var emotion: Emotion
    var energyLevel: Double // 0...1
    var source: CheckInSource
    var reflectionQuoteText: String
    var isBookmarked: Bool

    init(
        date: Date = .now,
        emotion: Emotion,
        energyLevel: Double,
        source: CheckInSource,
        reflectionQuoteText: String,
        isBookmarked: Bool = false
    ) {
        self.date = date
        self.emotion = emotion
        self.energyLevel = energyLevel
        self.source = source
        self.reflectionQuoteText = reflectionQuoteText
        self.isBookmarked = isBookmarked
    }
}
