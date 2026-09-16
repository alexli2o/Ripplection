//
//  ReflectionQuote.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation

/// A short reflective thought shown at the end of a check-in.
/// Populated from `ReflectionQuoteProvider`; mocked for now.
struct ReflectionQuote: Identifiable, Codable, Hashable {
    let id: UUID
    let text: String

    init(id: UUID = UUID(), text: String) {
        self.id = id
        self.text = text
    }
}
