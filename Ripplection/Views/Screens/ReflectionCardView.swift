//
//  ReflectionCardView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

/// Final step: shows the session's reflection quote, with bookmark/share actions.
struct ReflectionCardView: View {
    var viewModel: CheckInFlowViewModel
    let onDone: () -> Void

    @State private var isBookmarked = false
    
    private let cardSize = CGSize(width: 280, height: 420)
    
    /// Falls back to a neutral tint only if somehow no emotion was set —
    /// shouldn't happen in practice, since the flow requires a selection
    /// before advancing past `EmotionPickerView`.
    private var cardTint: Color {
            (viewModel.selectedEmotion?.color ?? .orange).opacity(0.375)
        }

    var body: some View {
        VStack(spacing: 32) {
            Text("A thought to hold…")
                .font(.title3.weight(.medium))

            GlassCard(tint: cardTint) {
                VStack(alignment: .leading, spacing: 24) {
                    Spacer(minLength: 0)
                    
                    Text(viewModel.reflectionQuote?.text ?? "")
                        .font(.title2.weight(.semibold))
                        .lineLimit(6)
                        .minimumScaleFactor(0.75)

                    Spacer(minLength: 0)
                    actionCapsule
//                    HStack {
//                        Button {
//                            isBookmarked.toggle()
//                        } label: {
//                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
//                        }
//                        ShareLink(item: viewModel.reflectionQuote?.text ?? "") {
//                            Image(systemName: "square.and.arrow.up")
//                        }
//                    }
//                    .buttonStyle(.plain)
//                    .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            .frame(width: cardSize.width, height: cardSize.height)

            Spacer()

            Button("Done", action: onDone)
                .buttonStyle(.glassProminent)
        }
        .padding(.top, 80)
        .padding(.bottom, 40)
    }

    private var actionCapsule: some View {
        GlassEffectContainer {
            HStack(spacing: 28) {
                Button {
                    isBookmarked.toggle()
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.title3.weight(.semibold))
                }

                ShareLink(item: viewModel.reflectionQuote?.text ?? "") {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3.weight(.semibold))
                }
            }
            .buttonStyle(.glass)
            .foregroundStyle(.primary)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
