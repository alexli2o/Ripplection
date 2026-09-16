//
//  FlowStep.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation

/// The ordered steps of a single guided check-in ritual.
enum FlowStep: Int, CaseIterable, Equatable {
    case breathing, emotion, energy, source, ripple, card

    var next: FlowStep? { FlowStep(rawValue: rawValue + 1) }
}
