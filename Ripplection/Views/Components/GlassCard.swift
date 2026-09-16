//
//  GlassCard.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//


import SwiftUI

/// A rounded, glass-backed content container reused for the reflection quote
/// card, and any other elevated surface.
struct GlassCard<Content: View>: View {
    private let cornerRadius: CGFloat
    private let tint: Color?
    private let content: Content

    init(cornerRadius: CGFloat = 28, tint: Color? = nil, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.tint = tint
        self.content = content()
    }

    var body: some View {
        content
            .padding(20)
            .glassEffect(tint.map { Glass.regular.tint($0) } ?? .regular, in: .rect(cornerRadius: cornerRadius))
    }
}

#Preview {
    GlassCard {
        Text("Anyone who has never made a mistake has never tried anything new.")
    }
    .padding()
}
