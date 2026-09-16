//
//  EmotionPickerView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

/// Second step: pick the emotion that best matches how the user feels right now.
struct EmotionPickerView: View {
    var viewModel: CheckInFlowViewModel

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 4) {
                Text("Take a moment.")
                Text("Feel it, then find where you are.")
            }
            .font(.title3.weight(.medium))
            .multilineTextAlignment(.center)

            EmotionFlowerView(selected: viewModel.selectedEmotion) { emotion in
                viewModel.selectEmotion(emotion)
            }

            Spacer()

            Button("Continue") { viewModel.advance() }
                .buttonStyle(.glass)
                .disabled(!viewModel.canAdvanceFromEmotion)
                .opacity(viewModel.canAdvanceFromEmotion ? 1 : 0.4)
        }
        .padding(.top, 80)
        .padding(.bottom, 40)
        .padding(.horizontal, 32)
    }
}
