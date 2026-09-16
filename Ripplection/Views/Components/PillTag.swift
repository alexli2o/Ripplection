//
//  PillTag.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

/// A single selectable chip, used for the check-in source options.
struct PillTag: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .glassEffect(isSelected ? Glass.regular.tint(.blue) : .regular, in: .capsule)
        }
        .buttonStyle(.plain)
    }
}
