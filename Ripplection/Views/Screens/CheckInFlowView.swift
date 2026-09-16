//
//  CheckInFlowView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI
import SwiftData

/// Coordinates the linear check-in ritual, presenting one screen per
/// `FlowStep` and forwarding completion back to the shared view model.
struct CheckInFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = CheckInFlowViewModel()

    var body: some View {
        ZStack {
            AmbientBackground()

            switch viewModel.step {
            case .breathing:
                BoxBreathingView(onFinished: viewModel.advance)
            case .emotion:
                EmotionPickerView(viewModel: viewModel)
            case .energy:
                PhysicalEnergyView(viewModel: viewModel)
            case .source:
                SourceSelectionView(viewModel: viewModel)
            case .ripple:
                RippleCTAView(viewModel: viewModel)
            case .card:
                ReflectionCardView(viewModel: viewModel) {
                    viewModel.saveEntry(in: modelContext)
                    dismiss()
                }
            }
        }
        .animation(.easeInOut, value: viewModel.step)
    }
}
