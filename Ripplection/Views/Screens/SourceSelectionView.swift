//
//  SourceSelectionView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

/// Fourth step: attribute the feeling to a source, using wrapping glass chips.
struct SourceSelectionView: View {
    var viewModel: CheckInFlowViewModel

    var body: some View {
        VStack(spacing: 40) {
            Text("Can you identify the source?")
                .font(.title3.weight(.medium))

            FlowLayout(spacing: 10) {
                ForEach(CheckInSource.allCases) { source in
                    PillTag(
                        title: source.displayName,
                        isSelected: viewModel.selectedSource == source
                    ) {
                        viewModel.selectSource(source)
                    }
                }
            }
            .frame(maxWidth: 280)

            Spacer()

            Button("Continue") { viewModel.advance() }
                .buttonStyle(.glass)
                .disabled(!viewModel.canAdvanceFromSource)
                .opacity(viewModel.canAdvanceFromSource ? 1 : 0.4)
        }
        .padding(.top, 80)
        .padding(.bottom, 40)
        .padding(.horizontal, 32)
    }
}
