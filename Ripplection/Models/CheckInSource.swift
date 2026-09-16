//
//  CheckInSource.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation

/// Where a feeling seems to originate from, selected on the "Source" step.
enum CheckInSource: String, CaseIterable, Identifiable, Codable, Hashable {
    case work, friends, family, school, other

    var id: String { rawValue }
    var displayName: String { rawValue.capitalized }
}
