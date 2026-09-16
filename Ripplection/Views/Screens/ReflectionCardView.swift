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

    var body: some View {
        VStack(spacing: 32) {
            Text("A thought to hold…")
                .font(.title3.weight(.medium))

            GlassCard(tint: .orange.opacity(0.3)) {
                VStack(alignment: .leading, spacing: 24) {
                    Text(viewModel.reflectionQuote?.text ?? "")
                        .font(.title3.weight(.medium))
                        .fixedSize(horizontal: false, vertical: true)

                    HStack {
                        Spacer()
                        Button {
                            isBookmarked.toggle()
                        } label: {
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        }
                        ShareLink(item: viewModel.reflectionQuote?.text ?? "") {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.primary)
                }
            }
            .frame(maxWidth: 320)

            Spacer()

            Button("Done", action: onDone)
                .buttonStyle(.glass)
        }
        .padding(.top, 80)
        .padding(.bottom, 40)
    }
}
