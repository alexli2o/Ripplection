//
//  BoxBreathingView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

/// The guided box-breathing screen: a 4-4-4-4 cycle with a breathing cube,
/// synced haptics, and ambient audio.
struct BoxBreathingView: View {
    @State private var viewModel = BreathingViewModel()
    let onFinished: () -> Void

    var body: some View {
        VStack(spacing: 48) {
            Text(viewModel.phase.instruction)
                .font(.title3.weight(.medium))

            BreathingCubeView(
                phase: viewModel.phase,
                progress: viewModel.phaseProgress,
                secondsRemaining: viewModel.secondsRemaining
            )

            Spacer()
        }
        .padding(.top, 80)
        .onAppear { viewModel.start() }
        .onDisappear { viewModel.stop() }
        .onChange(of: viewModel.isFinished) { _, finished in
            if finished { onFinished() }
        }
    }
}
