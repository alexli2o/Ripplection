//
//  Clamped.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation

extension Comparable {
    /// Clamps `self` into the given closed range. Shared by every drag-driven
    /// value in the app (orb fill level, wave shape level, etc.).
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
