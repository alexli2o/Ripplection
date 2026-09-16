//
//  ReflectionQuoteProvider.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation

protocol ReflectionQuoteProviding {
    func randomQuote() -> ReflectionQuote
}

/// Temporary mock data source for reflection quotes shown at the end of a
/// check-in. Replace with a real content source (bundled JSON, CMS, etc.) later.
final class MockReflectionQuoteProvider: ReflectionQuoteProviding {
    private let quotes: [ReflectionQuote] = [
        ReflectionQuote(text: "Anyone who has never made a mistake has never tried anything new."),
        ReflectionQuote(text: "Feelings are visitors. Let them come and go."),
        ReflectionQuote(text: "You don't have to control your thoughts. You just have to stop letting them control you."),
        ReflectionQuote(text: "Small ripples still change the shape of the water."),
        ReflectionQuote(text: "Rest is not idleness, it is part of the work."),
        ReflectionQuote(text: "What you pay attention to grows.")
    ]

    func randomQuote() -> ReflectionQuote {
        quotes.randomElement() ?? ReflectionQuote(text: "Take a breath. You're exactly where you need to be.")
    }
}
